class DropPushNotificationsUsersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :pushNotifications_users
  end
end
