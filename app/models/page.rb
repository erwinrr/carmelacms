class Page < ApplicationRecord
  belongs_to :organization
  has_many :users, through: :page_impressions
  has_one_attached :screenshot  
end
