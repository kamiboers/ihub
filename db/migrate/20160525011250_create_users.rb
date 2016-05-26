class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :uid
      t.string :image_path
      t.string :token
      t.string :key

      t.timestamps null: false
    end
  end
end
