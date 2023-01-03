class AddVideoUrl < ActiveRecord::Migration[7.0]
  def up
    add_column :episodes, :video, :boolean, default: false, null: false
  end

  def down
    remove_column :episodes, :video
  end
end
