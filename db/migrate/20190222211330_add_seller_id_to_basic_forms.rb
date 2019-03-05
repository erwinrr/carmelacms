class AddSellerIdToBasicForms < ActiveRecord::Migration[5.2]
  def change
    add_column :basic_forms, :seller_id, :integer
  end
end
