class AddStartTimeToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :start_time, :datetime
  end
end
