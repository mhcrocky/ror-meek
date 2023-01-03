class Article < ActiveRecord::Base
  attr_accessor :csv_file

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :image, default_url: ':default_media', styles: { normal: '200x200#', googlebot: "500x200>" }, convert_options: { googlebot: "-gravity center -extent 500x200"}
  has_attached_file :wallpaper, default_url: ':default_wallpaper', styles: { normal: '1350x500#' }

  belongs_to :category, class_name: 'Category', touch: true

  has_many :posts, class_name: 'Post', dependent: :destroy
  has_many :favorites, as: :favoritable, class_name: 'Favorite'
  has_many :users, through: :favorites

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :wallpaper, content_type: /\Aimage\/.*\Z/

  scope :ordered, -> { order(:name) }

  def normal_path
    image(:normal)
  end

  def wallpaper_path
    wallpaper(:normal)
  end

  private

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
