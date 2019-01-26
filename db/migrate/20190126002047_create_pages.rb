class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :slug
      t.integer :total_views
      t.text :data

      t.timestamps
    end
  end
end
