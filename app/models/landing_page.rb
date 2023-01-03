class LandingPage < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  validates :content, :name, :title, presence: true
end
