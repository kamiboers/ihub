class PagesController < ApplicationController
  before_action :set_auth
  def index
    redirect to dashboard_path if current_user
  end

  def dashboard
    redirect_to index_path if !current_user
    if current_user
      gs = GithubService.new(current_user.username, current_user.token)
      @repos = gs.get_repo_data
      @rate_limit = gs.rate_limit
      @search_limit = gs.search_limit
      @followers = gs.get_followers_data
      @pulls = gs.get_pull_data
      @starred = gs.starred_repos.count
      @orgs = gs.organizations.count
      @commits = gs.get_commit_data
    end

    def followers
      gs = GithubService.new(current_user.username, current_user.token)
      @events = gs.get_followers_activity.flatten
    end

  end

private

  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end

end
