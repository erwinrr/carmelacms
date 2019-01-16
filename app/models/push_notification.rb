class PushNotification < ApplicationRecord
    validates :title, presence: true
    validates :message, presence: true
    belongs_to :sender, class_name: "User"
    belongs_to :group, optional: true
    belongs_to :organization
    has_many :push_notification_posts
    has_many :users, through: :push_notification_posts
end
