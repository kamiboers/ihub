require 'rails_helper'
require 'spec_helper'

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
    
    expect(repos.count).to eq(30)
    expect(repo.name).to eq('ihub')
    expect(repo.html_url).to eq('https://github.com/kamiboers/ihub')
  end
end

  it "returns a list of commits" do
    VCR.use_cassette("github_service#commits") do
    service = GithubService.new("kamiboers", "710367e2c4d4c2400ed58e1b63224e4ccd0dd482")
    allow(service).to receive(:get_commit_data).and_return(return_commits)
    commits = service.get_commit_data
    commit = commits.first
    
    expect(commits.count).to eq(3)
    expect(commit[:commit][:message]).to eq('commits display')
    expect(commit[:commit][:url]).to eq('https://api.github.com/repos/kamiboers/ihub/git/commits/aaab5025cac67ebd092296a3fb34aad401ae2377')
  end
  end

end
