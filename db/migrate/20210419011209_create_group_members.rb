class CreateGroupMembers < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :groups do |t|
      t.index [:user_id, :group_id]
   end

  end
end
