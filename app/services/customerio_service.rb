class CustomerioService
  def self.subscribe_via_resque(user)
    Resque.enqueue(CustomerioWorker, 'subscribe', prepare_attributes(user))
  end
  def self.unsubscribe_via_resque(id)
    Resque.enqueue(CustomerioWorker, 'unsubscribe', id)
  end


  # NOTE: We add "#with_indifferent_access" method
  # Because of Resque provides hash of options as a hash of strings, but
  # "#identify" method accepts only symbols.
  def self.subscribe(object)
    $customerio.identify( object.with_indifferent_access )
  end

  def self.unsubscribe(id)
    $customerio.delete( id )
  end

  def self.prepare_attributes(user)
    # NOTE: If you change "prepare_attributes" method - don't forget to change CustomerioCallbacks.
    {
      id:             user.id,
      email:          user.email,
      full_name:      user.full_name,
      city:           user.address.city,
      state:          user.address.region.try(:name),
      zip:            user.address.postcode,
      country:        user.address.country.try(:name),
      church_name:    user.church_name,
      church_type:    user.church_type.try(:name),
      christian_for:  user.christian_for,
      favorite_verse: user.verse,
      birth_date:     user.birth_date,
      gender:         user.gender,
      language:       user.language,
      created_at:     user.created_at.to_i
    }
  end
end
