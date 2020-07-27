class AddIndexToMeals < ActiveRecord::Migration[5.2]
  def change
    add_index :meals, :name, length: 32
  end
end
