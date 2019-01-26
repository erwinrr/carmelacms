class RemoveDataFromPages < ActiveRecord::Migration[5.2]
  def change
    remove_column :pages, :data, :text
  end
end
