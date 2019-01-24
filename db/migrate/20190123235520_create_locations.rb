class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :country_code
      t.string :country_name
      t.string :county
      t.decimal :latitude
      t.decimal :longitude
      t.string :state
      t.string :street
      t.string :street_number
      t.string :town
      t.string :zip

      t.timestamps
    end
  end
end
