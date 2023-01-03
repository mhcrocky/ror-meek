class ChangeTypeOfBirthColumn < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :birth_date
    add_column :users, :birth_date, :date
  end

  def down
    remove_column :users, :birth_date
    add_column :users, :birth_date, :string, default: '', null: false
  end
end
