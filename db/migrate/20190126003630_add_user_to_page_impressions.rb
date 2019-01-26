class AddUserToPageImpressions < ActiveRecord::Migration[5.2]
  def change
    add_reference :page_impressions, :user, foreign_key: true
  end
end
