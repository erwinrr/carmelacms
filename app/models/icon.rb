class Icon < ApplicationRecord
  has_many :departments, dependent: :destroy 
end
