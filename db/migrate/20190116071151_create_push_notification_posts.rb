class CreatePushNotificationPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :push_notification_posts do |t|
      t.integer :push_notification_id
      t.integer :user_id
      t.boolean :is_published
      t.string :aws_message_id
      t.string :aws_error

      t.timestamps
    end
  end
end
