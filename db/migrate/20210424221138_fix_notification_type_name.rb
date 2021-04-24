class FixNotificationTypeName < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :type, :notification_type
  end
end
