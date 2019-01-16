class RemoveTypeFromPushNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :push_notifications, :type, :string
  end
end
