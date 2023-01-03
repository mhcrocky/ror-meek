class EditNoindexDefaultForEpisodes < ActiveRecord::Migration[7.0]
  def up
    change_column :episodes, :noindex, :boolean, default: false, null: false
  end

  def down
    change_column :episodes, :noindex, :boolean, default: true, null: false
  end
end
