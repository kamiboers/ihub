class PagesController < ApplicationController
  before_action :set_auth
  def index
    if current_user
      gs = GithubService.new
      gs.get_dashboard_data(current_user.token)
      # binding.pry
    end
  end

  def dashboard
    if current_user
      gs = GithubService.new
      @repos = gs.get_repo_data(current_user.token)
      @rate_limit = gs.rate_limit(current_user.token)
      @search_limit = gs.search_limit(current_user.token)
    end

  end

private

  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end

end
