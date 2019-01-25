class Organization < ApplicationRecord
  has_many :groups, inverse_of: :organization
  has_many :users, through: :groups
  has_many :cars, through: :groups
  has_many :locations, through: :users
  has_many :push_notifications
  accepts_nested_attributes_for :groups, reject_if: :all_blank, allow_destroy: true
end
