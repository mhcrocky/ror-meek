class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :wallpaper, default_url: ':default_wallpaper', styles: { normal: '1350x500#' }

  enum kind: { radio_station: 0, podcast: 1, article: 2 }

  before_validation :set_default_values

  has_many :podcasts
  has_many :radio_stations
  has_many :articles

  validates :kind, :h1, :meta_title, :meta_description, presence: true
  validates :name, presence: true, uniqueness: true

  validates :name, length: { maximum: 255 }
  validates :h1, length: { maximum: 255 }
  validates :meta_title, length: { maximum: 255 }

  validates_attachment_content_type :wallpaper, content_type: /\Aimage\/.*\Z/

  scope :ordered, -> { order(:position) }

  def wallpaper_path
    wallpaper(:normal)
  end

  private

  def set_default_values
    self.meta_title = self.name if self.meta_title.blank?
    self.h1 = self.name if self.h1.blank?
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
