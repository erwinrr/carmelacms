class AddOrganizationToCar < ActiveRecord::Migration[5.2]
  def change
    add_reference :cars, :organization, foreign_key: true
  end
end
