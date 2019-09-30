class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :full_name
      t.string :entry_type

      t.timestamps
    end
  end
end
