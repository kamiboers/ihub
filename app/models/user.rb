class User < ActiveRecord::Base
  validates :uid, presence: true
  validates :name, presence: true
  validates :username, presence: true
  validates :image_path, presence: true
  

  def self.sign_in_from_omniauth(auth)
    find_by(uid: auth['uid']) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    create!(
      uid: auth['uid'],
      name: auth['info'].name,
      username: auth['info']['nickname'],
      image_path: auth['info']['image'],
      token: auth['credentials']['token'],
      repo_count: auth['extra']['raw_info']['public_repos'],
      follower_count: auth['extra']['raw_info']['followers'],
      following_count: auth['extra']['raw_info']['following']
      )
  end

  

end