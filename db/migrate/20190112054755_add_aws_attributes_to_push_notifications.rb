class AddAwsAttributesToPushNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :push_notifications, :published, :boolean
    add_column :push_notifications, :aws_message_id, :string
    add_column :push_notifications, :aws_error, :string
    add_column :push_notifications, :type, :string
  end
end
