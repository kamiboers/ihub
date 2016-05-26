require 'net/http'
require 'faraday'
require 'JSON'
require 'pry'

class GithubService

  def initialize
    @connection = Faraday.new(url: "https://api.github.com")
  end

  def get_followers_data(username)
    response = @connection.get "/users/#{username}/followers"
    results = JSON.parse(response.body)
    results.map { |raw_follower|
      OpenStruct.new(raw_follower)
    }
  end

  def get_dashboard_data(token)
    response = @connection.get "/user", access_token: token
    results = JSON.parse(response.body)
    # binding.pry
  end

  def get_repo_data(token)
    response = @connection.get "/user/repos", access_token: token, sort: 'updated'
    results = JSON.parse(response.body)
    results.map { |repo|
      OpenStruct.new(repo)
    }
  end

  def rate_limit(token)
    response = @connection.get "/rate_limit", access_token: token
    results = JSON.parse(response.body)['rate']
    results['remaining']/(results['limit']).to_f
  end

  def search_limit(token)
     response = @connection.get "/rate_limit", access_token: token
    results = JSON.parse(response.body)['resources']['search']
    results['remaining']/(results['limit']).to_f
  end

end

if __FILE__ == $0
  gs = GithubService.new
    gs.get_repo_data('320943f5bc3b10b8dd2cceca2e3328e6239e2265')

end