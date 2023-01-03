class ChangeTypeChristianFor < ActiveRecord::Migration[7.0]
  def up
    change_column_null :users, :christian_for, true

    execute <<-SQL
      UPDATE users SET christian_for = null
    SQL

    change_column_default :users, :christian_for, nil
  end

  def down
    execute <<-SQL
      UPDATE users SET christian_for = '0.0'
    SQL

    change_column_null :users, :christian_for, false
    change_column_default :users, :christian_for, 0
  end
end
