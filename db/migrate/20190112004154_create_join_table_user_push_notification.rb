class CreateJoinTableUserPushNotification < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :pushNotifications do |t|
      # t.index [:user_id, :push_notification_id]
      # t.index [:push_notification_id, :user_id]
    end
  end
end
