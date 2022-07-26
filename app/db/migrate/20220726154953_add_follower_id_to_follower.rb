class AddFollowerIdToFollower < ActiveRecord::Migration[5.2]
  def change
    add_column :followers, :follower_id, :integer, null: false
  end
end
