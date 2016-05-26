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
      gs = GithubService.new
      @repos = gs.get_repo_data(current_user.token, current_user.username)
      @rate_limit = gs.rate_limit(current_user.token)
      @search_limit = gs.search_limit(current_user.token)
      @followers = gs.get_followers_data(current_user.username)
      pulls = gs.pulls.flatten.select { |pull| !pull.empty? }
      @pulls = pulls.select { |pull| pull['title'] != nil }
      @starred = gs.starred_repos(current_user.token).count
      @orgs = gs.organizations(current_user.token).count
      # @events = gs.get_events(current_user.token, current_user.username)
    end


  end

private

  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end

end
