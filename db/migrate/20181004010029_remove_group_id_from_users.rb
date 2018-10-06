class RemoveGroupIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :group_id, :bigint
  end
end
