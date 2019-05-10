class AddIconToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_reference :departments, :icon, foreign_key: true
  end
end
