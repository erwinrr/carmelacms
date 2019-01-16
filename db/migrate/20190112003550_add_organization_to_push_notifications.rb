class AddOrganizationToPushNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :push_notifications, :organization, foreign_key: true
  end
end
