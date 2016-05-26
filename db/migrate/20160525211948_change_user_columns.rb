class ChangeUserColumns < ActiveRecord::Migration
  def change
    remove_column :users, :key
    add_column :users, :repo_count, :integer
    add_column :users, :follower_count, :integer
    add_column :users, :following_count, :integer
  end
end
