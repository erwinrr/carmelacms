class CreateDepartmentUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :departments, :users do |t|
      t.index :department_id
      t.index :user_id
    end
  end
end
