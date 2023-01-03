class ActivecampaignService

  CONTACT_SYNC_URL = "#{ENV.fetch('ACTIVE_CAMPAIGN_URL')}/api/3/contact/sync".freeze
  CONTACT_LIST_URL = "#{ENV.fetch('ACTIVE_CAMPAIGN_URL')}/api/3/contactLists".freeze
  CONTACT_DELETE_URL = "#{ENV.fetch('ACTIVE_CAMPAIGN_URL')}/api/3/contacts/".freeze

  def self.subscribe_via_resque(user)
    Resque.enqueue(ActivecampaignWorker, 'subscribe', prepare_attributes(user))
  end

  def self.unsubscribe_via_resque(id)
    Resque.enqueue(ActivecampaignWorker, 'unsubscribe', id)
  end

  def self.subscribe(object)
    response = HTTParty.post(CONTACT_SYNC_URL, body: object, headers: headers)
    user = User.find(JSON.parse(object)['contact']['id'])
    user.update_column(:activecampaign_id, JSON.parse(response.body)['contact']['id'].to_i)
    HTTParty.post(CONTACT_LIST_URL, body: prepare_list_attributes(user), headers: headers)
  end

  def self.unsubscribe(id)
    HTTParty.delete(CONTACT_DELETE_URL + id.to_s, headers: headers)
  end

  def self.prepare_attributes(user)
    {
      contact:
        {
          id:             user.id,
          email:          user.email,
          first_name:     user.first_name,
          last_name:      user.last_name,
        }
    }.to_json
  end

  def self.prepare_list_attributes(user)
    {
      "contactList":
        {
          list:    ENV.fetch('ACTIVE_CAMPAIGN_MEEK_SUBCRIBERS_LIST_ID'),
          contact: user.activecampaign_id,
          status:  1
        }
    }.to_json
  end

  def self.headers
    { 'Api-Token': ENV.fetch('ACTIVE_CAMPAIGN_KEY') }
  end
end