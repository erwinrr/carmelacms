class AddUserToPushNotificationPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :push_notification_posts, :user, foreign_key: true
  end
end
