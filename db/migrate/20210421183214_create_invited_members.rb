class CreateInvitedMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :invited_members do |t|
      t.references :order, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :joind

      t.timestamps
    end
  end
end
