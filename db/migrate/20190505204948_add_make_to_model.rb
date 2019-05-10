class AddMakeToModel < ActiveRecord::Migration[5.2]
  def change
    add_reference :models, :make, foreign_key: true
  end
end
