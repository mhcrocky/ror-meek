class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :article, class_name: 'Article', touch: true

  has_one :category, through: :article, class_name: 'Category'

  has_many :favorites, as: :favoritable, class_name: 'Favorite'

  scope :ordered, -> { order(:name) }
  scope :with_search, -> (query) { where('name ILIKE ?', "%#{query}%") if query.present? }

  def released_at
    self.release_date.to_s(:meek_date)
  end

  private

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
