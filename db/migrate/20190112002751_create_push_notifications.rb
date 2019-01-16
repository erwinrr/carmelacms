class CreatePushNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :push_notifications do |t|
      t.string :title
      t.text :message

      t.timestamps
    end
  end
end
