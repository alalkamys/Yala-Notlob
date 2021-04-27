class CreateGroupParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :group_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
