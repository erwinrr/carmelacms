class Group < ApplicationRecord
  belongs_to :organization
  has_many :users
  has_many :cars
  has_many :departments
  has_one_attached :group_image
end
