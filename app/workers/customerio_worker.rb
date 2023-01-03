class CustomerioWorker

  @queue = 'default'
  def self.perform(action, options)
    CustomerioService.send(action, options)
  end
end
