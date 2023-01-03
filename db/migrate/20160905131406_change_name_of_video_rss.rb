class ChangeNameOfVideoRss < ActiveRecord::Migration[7.0]
  def up
    rename_column :podcasts, :video_stream_url, :video_youtube_feed

    add_column :podcasts, :video_vimeo_feed, :string
    add_column :podcasts, :video_rss_feed, :string
  end

  def down
    rename_column :podcasts, :video_youtube_feed, :video_stream_url

    remove_column :podcasts, :video_vimeo_feed
    remove_column :podcasts, :video_rss_feed
  end
end
