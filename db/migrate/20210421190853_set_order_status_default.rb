class SetOrderStatusDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :string, :default => "Active"
  end
end
