class RemoveSerialNumber < ActiveRecord::Migration[7.0]
  def up
    remove_column :episodes, :serial_number
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't recover serial numbers"
  end
end
