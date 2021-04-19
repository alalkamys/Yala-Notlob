class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :resturant_name
      t.string :mealtype
      t.integer :creator_id
      t.string :menu_img
      t.datetime :date
      t.string :status

      t.timestamps
    end
  end
end
