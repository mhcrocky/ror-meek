class ChangeBackgroundTable < ActiveRecord::Migration[7.0]
  def up
    add_column :backgrounds, :background_slider_file_name,    :string
    add_column :backgrounds, :background_slider_content_type, :string
    add_column :backgrounds, :background_slider_file_size,    :integer
    add_column :backgrounds, :background_slider_updated_at,   :datetime

    rename_column :backgrounds, :line_2, :background_slider_body

    remove_column :backgrounds, :wallpaper_file_name
    remove_column :backgrounds, :wallpaper_content_type
    remove_column :backgrounds, :wallpaper_file_size
    remove_column :backgrounds, :wallpaper_updated_at
  end

  def down
    remove_column :backgrounds, :background_slider_file_name
    remove_column :backgrounds, :background_slider_content_type
    remove_column :backgrounds, :background_slider_file_size
    remove_column :backgrounds, :background_slider_updated_at

    rename_column :backgrounds, :background_slider_body, :line_2

    add_column :backgrounds, :wallpaper_file_name,    :string
    add_column :backgrounds, :wallpaper_content_type, :string
    add_column :backgrounds, :wallpaper_file_size,    :integer
    add_column :backgrounds, :wallpaper_updated_at,   :datetime
  end
end
