class AddAutoPublishedAtToEpisode < ActiveRecord::Migration[7.0]
  def change
    ## if episode was autopublished
    add_column :episodes, :auto_published_at, :datetime
    add_column :episodes, :auto_published_as, :string, default: '', null: false
    ## freequency_type: 1 - daily, 2 - weekly, 3 - monthly
    add_column :episodes, :auto_publish_freequency_type, :integer, default: 0, null: false
  end
end
