class AddAwsColumns2ToPushNotificationsUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :push_notifications_users, :published, :boolean
  end
end
