class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :friend_id
      t.integer :user_id

      t.timestamps
    end
    add_index(:friendships, [:friend_id, :user_id], :unique => true)
  end
end
