class Region < ActiveRecord::Base
  belongs_to :country, class_name: 'Country', touch: true

  validates :country, presence: true
end
