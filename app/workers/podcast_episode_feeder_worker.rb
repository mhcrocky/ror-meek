class PodcastEpisodeFeederWorker

  @queue = 'default'
  def self.perform(id)
    PodcastEpisodeFeeder.import!(id)
  end

end
