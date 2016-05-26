require 'rails_helper'

describe GithubService do
  it "returns a list of followers belonging to a user" do
    VCR.use_cassette("github_service#followers") do
    service = GithubService.new("kamiboers", "320943f5bc3b10b8dd2cceca2e3328e6239e2265")
    followers = service.get_followers_data
    follower = followers.first

    expect(followers.count).to eq(10)
    expect(follower.login).to eq('GKhalsa')
    expect(follower.url).to eq('https://api.github.com/users/GKhalsa')
  end
end

  it "returns a list of repositories" do
    VCR.use_cassette("github_service#repos") do
    service = GithubService.new("kamiboers", "320943f5bc3b10b8dd2cceca2e3328e6239e2265")
    repos = service.get_repo_data
    repo = repos.first
    
    expect(legislators.count).to eq(20)
    expect(repo.title).to eq('ihub')
    expect(repo.html_url).to eq('https://github.com/kamiboers/ihub')
  end
  end

end
