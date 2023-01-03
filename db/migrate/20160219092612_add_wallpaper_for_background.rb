class AddWallpaperForBackground < ActiveRecord::Migration[7.0]
  def up
    add_column :backgrounds, :wallpaper_file_name,    :string
    add_column :backgrounds, :wallpaper_content_type, :string
    add_column :backgrounds, :wallpaper_file_size,    :integer
    add_column :backgrounds, :wallpaper_updated_at,   :datetime
  end

  def down
    remove_column :backgrounds, :wallpaper_file_name
    remove_column :backgrounds, :wallpaper_content_type
    remove_column :backgrounds, :wallpaper_file_size
    remove_column :backgrounds, :wallpaper_updated_at
  end
end
