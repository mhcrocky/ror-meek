class RenameFrequencyForPodcasts < ActiveRecord::Migration[7.0]
  def change
    rename_column :podcasts, :new_publish_freequency_type, :new_publish_frequency_type
    rename_column :podcasts, :old_publish_freequency_type, :old_publish_frequency_type
  end
end
