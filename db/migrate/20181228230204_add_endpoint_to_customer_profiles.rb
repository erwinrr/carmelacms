class AddEndpointToCustomerProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :customer_profiles, :endpoint, :string
  end
end
