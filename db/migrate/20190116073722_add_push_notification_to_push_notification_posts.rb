class AddPushNotificationToPushNotificationPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :push_notification_posts, :push_notification, foreign_key: true
  end
end
