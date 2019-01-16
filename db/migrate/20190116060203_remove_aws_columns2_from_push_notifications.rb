class RemoveAwsColumns2FromPushNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :push_notifications, :published, :boolean
  end
end
