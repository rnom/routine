class RenameBmiColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :bmi, :bmr
  end
end
