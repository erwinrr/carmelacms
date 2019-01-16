class RemoveAwsColumnsFromPushNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :push_notifications, :aws_message_id, :string
    remove_column :push_notifications, :aws_error, :string
  end
end
