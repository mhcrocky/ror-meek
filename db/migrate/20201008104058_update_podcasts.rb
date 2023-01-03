class UpdatePodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :create_transcription, :boolean, default: false
    add_column :podcasts, :transcript_only_new, :boolean, default: false
  end
end
