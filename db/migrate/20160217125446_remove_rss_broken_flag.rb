class RemoveRssBrokenFlag < ActiveRecord::Migration[7.0]
  def up
    remove_column :episodes, :broken
  end

  def down
    add_column :episodes, :broken, :boolean, default: false, null: false
  end
end
