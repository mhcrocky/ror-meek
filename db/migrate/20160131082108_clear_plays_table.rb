class ClearPlaysTable < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      TRUNCATE plays
    SQL
  end

  def down
  end
end
