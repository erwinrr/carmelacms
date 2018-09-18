class AddOrganizationToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :organization, foreign_key: true
  end
end
