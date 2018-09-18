class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :title
      t.string :vin_number
      t.string :stock_number
      t.integer :msrp_price
      t.integer :finance_payment
      t.integer :lease_payment
      t.string :engine
      t.string :transmission
      t.string :drivetrain
      t.string :exterior
      t.string :interior
      t.integer :hwy_mpg
      t.integer :city_mpg
      t.boolean :was_scraped
      t.string :scraped_url
      t.string :carinfo_url
      t.boolean :is_new
      t.boolean :is_used
      t.string :modelcode

      t.timestamps
    end
  end
end
