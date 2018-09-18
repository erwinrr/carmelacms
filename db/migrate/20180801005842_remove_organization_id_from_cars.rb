class RemoveOrganizationIdFromCars < ActiveRecord::Migration[5.2]
  def change
    remove_column :cars, :organization_id, :integer
  end
end
