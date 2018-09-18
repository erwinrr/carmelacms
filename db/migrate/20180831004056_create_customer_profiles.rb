class CreateCustomerProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_profiles do |t|

      t.timestamps
    end
  end
end
