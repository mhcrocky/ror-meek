class Podcast < ActiveRecord::Base
  attr_accessor :autopublish_old_date

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :image, default_url: ':default_media', styles: { normal: '200x200#', googlebot: "500x200>" }, convert_options: { googlebot: "-gravity center -extent 500x200"}
  has_attached_file :wallpaper, default_url: ':default_wallpaper', styles: { normal: '1350x500#' }

  belongs_to :category, class_name: 'Category', touch: true

  has_many :episodes, class_name: 'Episode', dependent: :destroy
  has_many :favorites, as: :favoritable, class_name: 'Favorite'
  has_many :users, through: :favorites

  before_validation :set_default_values
  before_validation :calculate_distance_in_days, if: -> { self.autopublish_old? }

  validates :name, :category, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :distance_in_days, presence: true, numericality: { only_integer: true, greater_than: 0 }, if: -> { self.autopublish_old? }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :wallpaper, content_type: /\Aimage\/.*\Z/

  scope :ordered, -> { order(:name) }
  scope :broken, -> { where(feed_is_broken: true) }

  def normal_path
    image(:normal)
  end

  def wallpaper_path
    wallpaper(:normal)
  end


  def find_next_prev_for(episode_id)
    episodes = self.episodes.order(release_date: :desc, id: :asc)

    next_episode = nil
    prev_episode = nil
    founded = false

    episodes.each do |e|
      if e.id == episode_id
        founded = true
        next
      end

      if !founded
        next_episode = e
      end

      if founded
        prev_episode = e
        break
      end
    end

    [next_episode, prev_episode]
  end

  def autopublish_old_start_date
    return nil unless self.autopublish_old
    Date.today - self.distance_in_days
  end

  private

  def set_default_values
    self.h1 = [h1, name].select(&:presence).first
    self.meta_title = [meta_title, name].select(&:presence).first
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end

  def calculate_distance_in_days
    if autopublish_old_date.blank?
      errors.add(:autopublish_old_date, 'Date should be set')
      return false
    end

    self.distance_in_days = (Date.today - autopublish_old_date.to_date).to_i

    if distance_in_days <= 0
      errors.add(:autopublish_old_date, 'Date should be lower than Today')
    end
  end
end
