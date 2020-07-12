class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string  :name
      t.float :protein
      t.float :fat
      t.float :carb
      t.float :cal
      t.float :user_id, foreign_key: true
      t.timestamps
    end
  end
end
