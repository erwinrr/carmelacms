class Car < ApplicationRecord
  belongs_to :group
  has_many :likes, dependent: :destroy
  has_one :organization, through: :group
end
