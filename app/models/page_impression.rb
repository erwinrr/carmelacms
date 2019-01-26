class PageImpression < ApplicationRecord
  belongs_to :page 
  belongs_to :user
end
