class AddPalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pal, :float
    add_column :users, :tdee, :float
  end
end
