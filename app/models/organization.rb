class Organization < ApplicationRecord
  has_many :groups
  has_many :users, through: :groups
  has_many :cars, through: :groups
  has_many :push_notifications
end
