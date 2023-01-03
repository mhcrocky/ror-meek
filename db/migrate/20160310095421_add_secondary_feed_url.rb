class AddSecondaryFeedUrl < ActiveRecord::Migration[7.0]
  def up
    add_column :podcasts, :secondary_feed_url, :string
  end

  def down
    remove_columns :podcasts, :secondary_feed_url
  end
end
