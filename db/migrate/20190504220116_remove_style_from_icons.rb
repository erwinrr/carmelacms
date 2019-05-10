class RemoveStyleFromIcons < ActiveRecord::Migration[5.2]
  def change
    remove_column :icons, :style, :string
  end
end
