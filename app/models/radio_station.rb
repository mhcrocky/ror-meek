class RadioStation < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :image, default_url: ':default_media', styles: { normal: '200x200#', googlebot: "500x200>" }, convert_options: { googlebot: "-gravity center -extent 500x200"}
  has_attached_file :wallpaper, default_url: ':default_wallpaper', styles: { normal: '1350x500#' }

  belongs_to :category, class_name: 'Category', touch: true

  has_many :favorites, as: :favoritable, class_name: 'Favorite'
  has_many :users, through: :favorites
  has_many :plays, as: :media, dependent: :destroy


  before_validation :set_default_values

  validates :name, :category, :stream_url, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :stream_url, url: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  scope :ordered, -> { order(:name) }


  def stream_metadata
    stream_metadata = {}

    begin
      Timeout.timeout(5) do
        Shoutout::Stream.open(self.stream_url) do |stream|
          stream_metadata[:artist] = stream.metadata.artist
          stream_metadata[:song] = stream.metadata.song
        end
      end
    rescue
      # do nothing
    end

    return stream_metadata
  end

  def normal_path
    image(:normal)
  end

  def wallpaper_path
    wallpaper(:normal)
  end

  def duration
    nil
  end

  private

  def set_default_values
    self.h1 = [h1, name].select(&:presence).first
    self.meta_title = [meta_title, name].select(&:presence).first
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
