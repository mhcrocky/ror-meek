class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  belongs_to :country

  validates :user_id, presence: true

  def as_json(options={})
    result = super
    result['country'] = self.country
    result['region'] = self.region
    return result
  end
end
