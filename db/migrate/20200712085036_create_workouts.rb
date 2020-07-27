class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string     :menu,         null: false
      t.integer    :weight,       null: false
      t.integer    :set,          null: false
      t.string     :bodypart,     null: false
      t.integer    :cal
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
