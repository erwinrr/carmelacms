class Car < ApplicationRecord
  belongs_to :group
  has_one :organization, through: :group
end
