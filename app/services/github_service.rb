class GithubService

  attr_reader :pulls

  def initialize
    @connection = Faraday.new(url: "https://api.github.com")
    @pulls = []
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
  end

  def get_repo_data(token, username)
    response = @connection.get "/user/repos", access_token: token, sort: 'updated'
    results = JSON.parse(response.body)
    results.map { |repo|
      get_pull_data(repo['name'], token, username)
      OpenStruct.new(repo)
    }
  end

  def get_pull_data(repo, token, username)
  response = @connection.get "/repos/#{username}/#{repo}/pulls", access_token: token, sort: 'updated', state: 'all'
  results = JSON.parse(response.body)
  @pulls << results
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

  def starred_repos(token)
    response = @connection.get "https://api.github.com/users/kamiboers/starred", access_token: token
    results = JSON.parse(response.body)
  end
  
  def organizations(token)
    response = @connection.get "https://api.github.com/users/kamiboers/orgs", access_token: token
    results = JSON.parse(response.body)
  end

end