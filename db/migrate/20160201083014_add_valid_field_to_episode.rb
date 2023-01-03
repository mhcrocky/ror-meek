class AddValidFieldToEpisode < ActiveRecord::Migration[7.0]
  def up
    add_column :episodes, :broken, :boolean, default: false, null: false
  end

  def down
    remove_column :episodes, :broken
  end
end
