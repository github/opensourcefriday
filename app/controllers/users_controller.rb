class UsersController < ApplicationController
  def show
    github_user = octokit.user params[:id]
    @avatar = github_user.avatar_url
    @name = github_user.name
    @nickname = github_user.login
    @name_or_nickname = @name || @nickname
    @bio = github_user.bio
    @company = github_user.company
    @location = github_user.location
    @homepage = github_user.homepage

    @orgs = organisations

    @user_is_current = current_user &&
                       current_user.github_username == @nickname

    @user_exists = User.exists? github_username: @nickname
    if @user_exists
      query_prs
      query_events
    end
    @prs ||= []
    @events ||= []

    render :show
  end

  private

  def organisations
    octokit.organizations(@nickname).map do |org|
      { name: org.login, avatar: org.avatar_url }
    end
  end

  def query_prs
    query = "is:pr author:#{@nickname} is:public"
    friday = Date.today.beginning_of_week :friday
    52.times { |i| query += " created:#{friday - (i * 7).days}" }

    prs = Rails.cache.fetch("#{@nickname}/prs", expires_in: 7.days) do
      octokit.search_issues query, sort: :created
    end
    @prs_count = prs.total_count
    @prs_incomplete = prs.items.size < prs.total_count
    @prs = prs.items.map do |pr|
      repo_name = pr.repository_url.sub(%r{^https://api.github.com/repos/}, "")
      {
        title: pr.title,
        url: pr.html_url,
        date: (pr.closed_at || pr.created_at).to_date,
        repo: repo_name,
      }
    end
    @prs = @prs.group_by { |pr| pr[:date] }
  end

  def query_events
    next_saturday = (Date.today + 7).beginning_of_week :saturday
    days_until_next_saturday = (next_saturday - Date.today).to_i
    duration_until_next_saturday = days_until_next_saturday.days

    events = Rails.cache.fetch("#{@nickname}/public_events",
                               expires_in: duration_until_next_saturday) do
      octokit.user_public_events(@nickname)
    end

    @events = events.map { |event| event_metadata(event) }.compact
    @events_count = @events.length
    @events = @events.group_by { |event| event[:date] }
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
        config.auto_paginate = true

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
