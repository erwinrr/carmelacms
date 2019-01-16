class AddSenderIdToPushNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :push_notifications, :sender_id, :integer
  end
end
