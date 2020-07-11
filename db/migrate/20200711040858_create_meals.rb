class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :name
      t.integer :protein
      t.integer :fat
      t.integer :carb
      t.integer :cal
      t.integer :user_id, foreign_key: true
      t.timestamps
    end
  end
end
