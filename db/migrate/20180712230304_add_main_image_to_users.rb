class AddMainImageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :main_image, :string
  end
end
