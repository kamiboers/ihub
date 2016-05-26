require 'rails_helper'

describe GithubService do
  it "returns a list of followers belonging to a user" do
    VCR.use_cassette("github_service#followers") do
    service = GithubService.new
    followers = service.get_followers_data("kamiboers")
    follower = followers.first

    expect(followers.count).to eq(10)
    expect(follower.login).to eq('GKhalsa')
    expect(follower.url).to eq('https://api.github.com/users/GKhalsa')
  end
  end
  
end
