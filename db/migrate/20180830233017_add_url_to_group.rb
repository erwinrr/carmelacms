class AddUrlToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :scrape_url, :string
  end
end
