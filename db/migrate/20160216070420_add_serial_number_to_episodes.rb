class AddSerialNumberToEpisodes < ActiveRecord::Migration[7.0]
  def up
    add_column :episodes, :serial_number, :integer
  end

  def down
    remove_column :episodes, :serial_number
  end
end
