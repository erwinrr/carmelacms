class CreateBasicForms < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_forms do |t|
      t.text :data

      t.timestamps
    end
  end
end
