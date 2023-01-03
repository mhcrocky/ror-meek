class AddTranscriptionToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :transcription, :text
  end
end
