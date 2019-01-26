class AddPageToPageImpressions < ActiveRecord::Migration[5.2]
  def change
    add_reference :page_impressions, :page, foreign_key: true
  end
end
