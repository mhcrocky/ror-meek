class StaticPage < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subject, use: :slugged

  enum subject: { about: 0, terms: 1, privacy: 2 }

  validates :content, :name, :subject, :title, presence: true
  validates :subject, uniqueness: true


  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
