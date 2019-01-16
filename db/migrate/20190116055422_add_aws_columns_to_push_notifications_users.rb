class AddAwsColumnsToPushNotificationsUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :push_notifications_users, :aws_message_id, :string
    add_column :push_notifications_users, :aws_error, :string
  end
end
