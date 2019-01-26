class CreatePageImpressions < ActiveRecord::Migration[5.2]
  def change
    create_table :page_impressions do |t|
      t.text :data

      t.timestamps
    end
  end
end
