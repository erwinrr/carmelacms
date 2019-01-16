class AddGroupToPushNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :push_notifications, :group, foreign_key: true
  end
end
