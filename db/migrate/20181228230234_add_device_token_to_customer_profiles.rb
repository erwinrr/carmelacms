class AddDeviceTokenToCustomerProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :customer_profiles, :device_token, :string
  end
end
