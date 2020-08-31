class ChangeDatatypeHeightOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :height, :integer
    change_column :users, :age, :integer
  end
end
