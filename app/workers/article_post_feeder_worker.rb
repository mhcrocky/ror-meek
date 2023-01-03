class ArticlePostFeederWorker
  @queue = 'default'
  def self.perform(id)
    ArticlePostFeeder.import!(id)
  end  
end
