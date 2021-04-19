class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :groups, :user_id, :owner_id
  end
end
