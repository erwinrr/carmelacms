class AddDeviceTypeToCustomerProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :customer_profiles, :device_type, :string
  end
end
