
namespace :activecampaign_sync do
  CONTACTS_FETCH_URL = "#{ENV.fetch('ACTIVE_CAMPAIGN_URL')}/api/3/contacts".freeze

  desc 'Set active_campaign_id to Users'

  task run: :environment do
    contacts = HTTParty.get(CONTACTS_FETCH_URL, headers: { 'Api-Token': ENV.fetch('ACTIVE_CAMPAIGN_KEY') })
    
    JSON.parse(contacts.body)['contacts'].each do |contact|
      user = User.find_by(email: contact['email'])
      if user.present?
        user.activecampaign_id = contact['id']
        user.save!
      end
    end
  end
end