class AddOrganizationToPages < ActiveRecord::Migration[5.2]
  def change
    add_reference :pages, :organization, foreign_key: true
  end
end
