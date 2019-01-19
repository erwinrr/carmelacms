class Group < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, reject_if: :all_blank, allow_destroy: true
  has_many :cars
  has_many :departments
  has_many :push_notifications
  has_one_attached :group_image
end
