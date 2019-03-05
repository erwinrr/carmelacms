class BasicForm < ApplicationRecord
  belongs_to :user
  belongs_to :seller, class_name: "User"
  has_many :organizations, through: :user
  has_many :comments
end
