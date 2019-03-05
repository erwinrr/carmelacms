class AddFormAttachedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :form_attached, :datetime
  end
end
