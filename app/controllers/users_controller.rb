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

    orgs = octokit.organizations @nickname
    @orgs = orgs.map { |org| { name: org.login, avatar: org.avatar_url } }

    @user_exists = User.exists? github_username: @nickname
    if @user_exists
      get_prs
    end
    @prs ||= []

    render :show
  end

  private

  def get_prs
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
    end.group_by { |pr| pr[:date] }
  end

  def octokit
    @octokit ||= begin
      client = Octokit::Client.new
      client.configure do |config|
        config.per_page = 100
        auto_paginate = true

        if current_user
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
