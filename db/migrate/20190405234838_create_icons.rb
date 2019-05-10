class CreateIcons < ActiveRecord::Migration[5.2]
  def change
    create_table :icons do |t|
      t.string :name
      t.string :set

      t.timestamps
    end
  end
end
