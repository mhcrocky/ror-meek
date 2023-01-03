module ActivecampaignCallbacks
  extend ActiveSupport::Concern

  included do
    after_create :create_activecampaign_subscription
    after_update :update_activecampaign_subscription

    after_destroy :remove_activecampaign_subscription
  end

  def create_activecampaign_subscription
    update_subscription(self)
  end

  def update_activecampaign_subscription
    user_apropriate_keys      = ['email', 'first_name', 'last_name', 'church_name', 'christian_for', 'verse', 'birth_date', 'gender', 'language', 'church_type_id']
    addresses_apropriate_keys = ['city', 'region_id', 'postcode', 'country_id']
    if ( (self.address.changed & addresses_apropriate_keys) + (self.changed & user_apropriate_keys) ).any?
      update_subscription(self)
    end
  end

  def update_subscription(user)
    ActivecampaignService.subscribe_via_resque(user)
  end

  def remove_activecampaign_subscription
    ActivecampaignService.unsubscribe_via_resque(self.activecampaign_id)
  end
end
