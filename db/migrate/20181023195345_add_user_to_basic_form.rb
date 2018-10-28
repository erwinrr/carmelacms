class AddUserToBasicForm < ActiveRecord::Migration[5.2]
  def change
    add_reference :basic_forms, :user, foreign_key: true
  end
end
