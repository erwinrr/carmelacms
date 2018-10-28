class AddTypeToBasicForms < ActiveRecord::Migration[5.2]
  def change
    add_column :basic_forms, :category, :string
  end
end
