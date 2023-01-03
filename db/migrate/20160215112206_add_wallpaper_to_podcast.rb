class AddWallpaperToPodcast < ActiveRecord::Migration[7.0]
  def up
    add_column :podcasts, :wallpaper_file_name,      :string
    add_column :podcasts, :wallpaper_content_type,   :string
    add_column :podcasts, :wallpaper_file_size,      :integer
    add_column :podcasts, :wallpaper_updated_at,     :datetime


    add_column :radio_stations, :wallpaper_file_name,      :string
    add_column :radio_stations, :wallpaper_content_type,   :string
    add_column :radio_stations, :wallpaper_file_size,      :integer
    add_column :radio_stations, :wallpaper_updated_at,     :datetime


    add_column :categories, :wallpaper_file_name,      :string
    add_column :categories, :wallpaper_content_type,   :string
    add_column :categories, :wallpaper_file_size,      :integer
    add_column :categories, :wallpaper_updated_at,     :datetime
  end

  def down
    remove_column :podcasts, :wallpaper_file_name
    remove_column :podcasts, :wallpaper_content_type
    remove_column :podcasts, :wallpaper_file_size
    remove_column :podcasts, :wallpaper_updated_at

    remove_column :radio_stations, :wallpaper_file_name
    remove_column :radio_stations, :wallpaper_content_type
    remove_column :radio_stations, :wallpaper_file_size
    remove_column :radio_stations, :wallpaper_updated_at

    remove_column :categories, :wallpaper_file_name
    remove_column :categories, :wallpaper_content_type
    remove_column :categories, :wallpaper_file_size
    remove_column :categories, :wallpaper_updated_at
  end
end
