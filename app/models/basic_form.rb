class BasicForm < ApplicationRecord
  belongs_to :user
  has_many :organizations, through: :user
end
