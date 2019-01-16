class RemoveReferenceFromPushNotificationPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :push_notification_posts, :user_id, :integer
    remove_column :push_notification_posts, :push_notification_id, :integer
  end
end
