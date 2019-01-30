class Car < ApplicationRecord
  belongs_to :group
  has_many :likes
  has_one :organization, through: :group
end
