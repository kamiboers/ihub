class GithubService

  attr_reader :user, :token, :stats

  def initialize(username, token)
    @connection = Faraday.new(url: "https://api.github.com")
    @user = username
    @token = token
    @stats = StatStorer.new(username)
  end

  def get_followers_data
    results = parse(@connection.get "/users/#{user}/followers")
    results.map { |raw_follower|
      OpenStruct.new(raw_follower)
    }
  end

  def get_repo_data
    results = parse(@connection.get "/user/repos", access_token: token, sort: 'updated')
    results.map { |repo|
      OpenStruct.new(repo)
    }
  end

  def get_pull_data
    repos = get_repo_data
    pulls = repos.inject([]) do |repo_pulls, repo|
      repo_pulls << parse(@connection.get "/repos/#{user}/#{repo.name}/pulls", access_token: token, sort: 'updated', state: 'all')
    end
    pulls = pulls.flatten.select { |pull| pull if !pull.empty? }
    pulls = pulls.select { |pull| pull if pull[:title] != nil }
  end

  def get_commit_data
    repos = get_repo_data
    commits = repos.inject([]) do |repo_commits, repo|
      repo_commits << parse(@connection.get "/repos/#{user}/#{repo.name}/commits", access_token: token, sort: 'updated', state: 'all')
    end
    commits = commits.flatten.select { |commit| commit if !commit.empty? }
    commits = commits.select { |commit| commit if commit[:commit] != nil }
  end

  def rate_limit
    results = parse(@connection.get "/rate_limit", access_token: token)[:rate]
    results[:remaining]/(results[:limit]).to_f
  end

  def search_limit
    results = parse(@connection.get "/rate_limit", access_token: token)[:resources][:search]
    results[:remaining]/(results[:limit]).to_f
  end

  def starred_repos
    parse(@connection.get "https://api.github.com/users/#{user}/starred", access_token: token)
  end
  
  def organizations
    response = parse(@connection.get "https://api.github.com/users/#{user}/orgs", access_token: token)
  end

  private

  def parse(input)
    JSON.parse(input.body, symbolize_names: true)
  end

end