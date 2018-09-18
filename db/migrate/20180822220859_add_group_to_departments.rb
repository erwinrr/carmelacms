class AddGroupToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_reference :departments, :group, foreign_key: true
  end
end
