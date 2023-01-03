class Episode < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug_candidates, use: :scoped, scope: :podcast

  belongs_to :podcast, class_name: 'Podcast', touch: true

  has_one :category, through: :podcast, class_name: 'Category'

  has_many :favorites, as: :favoritable, class_name: 'Favorite'
  has_many :users, through: :favorites
  has_many :plays, as: :media, dependent: :destroy
  has_many :share_queues

  before_destroy :cleanup

  before_validation :set_default_values

  validates :h1, :meta_title, :podcast, :name, :release_date, :stream_url, presence: true
  validates :stream_url, url: true
  validates :stream_url, uniqueness: { scope: :podcast }

  scope :ordered, -> { order(release_date: :desc, id: :asc) }
  scope :audio_only, -> { where(video: false) }
  scope :video_only, -> { where(video: true) }

  scope :only_new_episodes, -> { where('release_date >= ?', Date.current - 1.day) }
  scope :non_shared, -> { where(already_shared: false) }
  scope :with_publish_date, -> (date) { where(release_date: date) }
  scope :with_search, -> (query) { where('name ILIKE ?', "%#{query}%") if query.present? }


  def released_at
    #self.release_date.to_s(:meek_date)
    self.release_date.to_fs(:meek_date)
  end

  def stream_url_type
    return nil unless self.video?
    uri_host = URI( self.stream_url ).host

    case (uri_host)
    when 'www.youtube.com'
      return 'video/youtube'
    when 'vimeo.com'
      return 'video/vimeo'
    else
      return 'video/mp4'
    end
  end

  private

  def set_default_values
    self.meta_title = "#{self.podcast.name} - #{self.name}" if self.meta_title.blank? && self.podcast
    self.h1 = self.name if self.h1.blank?
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end

  def slug_candidates
    [
      :name,
      [:name, :release_date],
      [:name, :release_date, :id]
    ]
  end

  def cleanup
    self.share_queues.without_publish_date.delete_all
  end
end
