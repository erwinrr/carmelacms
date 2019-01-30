class AddCarIdToLikes < ActiveRecord::Migration[5.2]
  def change
    add_reference :likes, :car, foreign_key: true
  end
end
