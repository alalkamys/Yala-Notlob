class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :receiver, null: false
      t.references :order, null: false, foreign_key: true
      t.references :sender, null: false
      t.boolean :viewed
      t.integer :type, default: 0
      t.datetime :read_at

      t.timestamps
    end
  end
end
