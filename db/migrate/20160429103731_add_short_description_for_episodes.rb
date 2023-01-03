class AddShortDescriptionForEpisodes < ActiveRecord::Migration[7.0]
  def change
    ## if feed contains short description of the episode
    add_column :episodes, :short_description, :text, default: '', null: false
  end
end
