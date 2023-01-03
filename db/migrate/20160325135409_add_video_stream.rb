class AddVideoStream < ActiveRecord::Migration[7.0]
  def up
    add_column :podcasts, :video_stream_url, :string
  end

  def down
    remove_column :podcasts, :video_stream_url
  end
end
