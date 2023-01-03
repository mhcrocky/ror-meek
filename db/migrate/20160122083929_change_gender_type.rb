class ChangeGenderType < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE users SET gender = ''
    SQL
  end
end
