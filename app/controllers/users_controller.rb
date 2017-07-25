class UsersController < ApplicationController
  def show
    @avatar, @name, @nickname, @bio, @company, @location, @homepage, @orgs =
      Rails.cache.fetch(
        "#{params[:id]}/user_metadata",
        expires_in: 1.day
      ) do
        github_user = octokit.user params[:id]
        nickname = github_user.login
        [
          github_user.avatar_url,
          github_user.name,
          nickname,
          github_user.bio,
          github_user.company,
          github_user.location,
          github_user.homepage,
          organisations(nickname),
        ]
      end
    @name_or_nickname = @name || @nickname

    @user_is_current = current_user &&
                       current_user.github_username == @nickname

    @user_exists = User.exists? github_username: @nickname
    @user_exists ||= params[:user_exists] unless Rails.env.production?
    if @user_exists
      @prs_count, @prs_incomplete, @prs = query_prs
      @events_count, @events = query_events
      @prs_and_events = (@prs + @events).group_by { |pr| pr[:date] }
    end
    @prs_and_events ||= []

    render :show
  rescue Octokit::NotFound
    flash[:error] = "GitHub user @#{params[:id]} not found!"
    redirect_to root_path
  end

  private

  def organisations(user)
    octokit.organizations(user).map do |org|
      { name: org.login, avatar: org.avatar_url }
    end
  end

  def query_prs
    Rails.cache.fetch(
      "#{@nickname}/prs_metadata",
      expires_in: duration_until_next_saturday
    ) do
      query = "is:pr author:#{@nickname} is:public"
      friday = Date.today.beginning_of_week :friday
      # for the last 3 months
      13.times { |i| query += " created:#{friday - (i * 7).days}" }

      prs = octokit.search_issues query, sort: :created
      last_response = octokit.last_response
      while last_response.rels[:next]
        last_response = last_response.rels[:next].get
        prs.concat last_response.data
      end
      total = prs.total_count
      incomplete = prs.items.size < total
      prs = prs.items.map do |pr|
        repo_name = pr.repository_url
                      .sub(%r{^https://api.github.com/repos/}, "")
        {
          title: pr.title,
          url: pr.html_url,
          date: pr.created_at.to_date,
          repo: repo_name,
        }
      end
      [total, incomplete, prs]
    end
  end

  def query_events
    Rails.cache.fetch(
      "#{@nickname}/public_events_metadata",
      expires_in: duration_until_next_saturday
    ) do
      events = octokit.user_public_events(@nickname)
      last_event_created = events.last.try(:created_at) || DateTime.now
      last_response = octokit.last_response
      while last_event_created > 3.months.ago && last_response.rels[:next]
        last_response = last_response.rels[:next].get
        events.concat last_response.data
        last_event_created = events.last.try(:created_at) || DateTime.now
      end
      count = events.length
      events = events.map { |event| event_metadata(event) }.compact
      [count, events]
    end
  end

  def duration_until_next_saturday
    @duration_until_next_saturday ||= begin
      next_saturday = (Date.today + 7).beginning_of_week :saturday
      days_until_next_saturday = (next_saturday - Date.today).to_i
      days_until_next_saturday.days
    end
  end

  def event_metadata(event)
    action = event.action
    payload = event.payload

    url = nil
    date = nil
    repo = event.repo.name

    case event.type
    when "IssuesEvent"
      return unless action == "closed"
      issue = payload.issue
      url = issue.html_url
      date = issue.closed_at
      return if issue.user.login == @nickname
      title = "closed #{issue.title}"
    when "PushEvent"
      diff = "#{payload.before}...#{payload.head}"
      url = "https://github.com/#{repo}/compare/#{diff}"
      date = event.created_at
      branch = payload.ref.sub(%r{^refs/heads/}, "")
      title = "pushed <code>#{branch}</code>".html_safe
    when "PullRequestReviewEvent"
      return unless action == "submitted"
      review = event.review
      url = review.html_url
      date = review.submitted_at
      title = "reviewed #{event.pull_request.title}"
    when "ReleaseEvent"
      return unless action == "published"
      release = event.release
      url = release.html_url
      date = release.published_at
      title = "released #{release.name || release.tag_name}"
    end
    return if !title || !url || !date || !repo

    date = date.to_date
    return unless date.friday?

    {
      title: title,
      url: url,
      date: date,
      repo: repo,
    }
  end

  def octokit
    @octokit ||= begin
      client = Octokit::Client.new
      client.configure do |config|
        config.per_page = 100

        if current_user && !Rails.env.test?
          config.access_token = current_user.oauth_token
        else
          config.client_id = ENV["github_client_id"]
          config.client_secret = ENV["github_client_secret"]
        end
      end
      client
    end
  end
end
