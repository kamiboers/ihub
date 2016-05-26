class PagesController < ApplicationController
  before_action :set_auth
  def index
    if current_user
      gs = GithubService.new
      gs.get_dashboard_data(current_user.token)
    end
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
      # @events = gs.get_events(current_user.token, current_user.username)
    end

  end

private

  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end

end
