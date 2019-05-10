class RemoveIconFromDepartments < ActiveRecord::Migration[5.2]
  def change
    remove_column :departments, :icon, :string
  end
end
