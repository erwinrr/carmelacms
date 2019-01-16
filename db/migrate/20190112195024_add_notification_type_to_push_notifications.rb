class AddNotificationTypeToPushNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :push_notifications, :notification_type, :string
  end
end
