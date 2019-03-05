class Comment < ApplicationRecord
  belongs_to :basic_form
  belongs_to :user
end
