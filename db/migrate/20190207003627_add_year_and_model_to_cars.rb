class AddYearAndModelToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :year, :integer
    add_column :cars, :model, :string
  end
end
