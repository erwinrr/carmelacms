class PushNotificationPost < ApplicationRecord
    belongs_to :user
    belongs_to :push_notification
end
