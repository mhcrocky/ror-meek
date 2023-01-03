class ActivecampaignWorker
  @queue = 'default'

  def self.perform(action, options)
    ActivecampaignService.send(action, options)
  end
end
