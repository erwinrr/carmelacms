class AddGroupIdToCars < ActiveRecord::Migration[5.2]
  def change
    add_reference :cars, :group, foreign_key: true
  end
end
