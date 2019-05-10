class Model < ApplicationRecord
  belongs_to :make, optional: true
end
