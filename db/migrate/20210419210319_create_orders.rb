class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :resturant_name
      t.string :mealtype
      t.references :user, null: false, foreign_key: true
      t.string :menu_img
      t.string :status

      t.timestamps
    end
  end
end
