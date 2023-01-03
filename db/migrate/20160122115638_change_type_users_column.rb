class ChangeTypeUsersColumn < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :christian_for, :decimal, precision: 8, scale: 2, default: 0, null: false
  end

  def down
    change_column :users, :christian_for, :integer
  end
end
