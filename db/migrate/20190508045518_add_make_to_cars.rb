class AddMakeToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :make, :string
  end
end
