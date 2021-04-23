class CreateOrderMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :order_members do |t|
      t.references :order, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :comment
      t.string :item
      t.integer :amount
      t.float :price

      t.timestamps
    end
  end
end
