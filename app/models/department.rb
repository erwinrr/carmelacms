class Department < ApplicationRecord
  belongs_to :group
  belongs_to :icon, dependent: :destroy
  has_and_belongs_to_many :users
end
