class User < ActiveRecord::Base
  attr_accessor :month, :day, :year

  extend FriendlyId

  include CustomerioCallbacks unless Rails.env.development?
  include ActivecampaignCallbacks unless Rails.env.development?
  friendly_id :username, use: :slugged     

  # Include default devise modules. Others available are:
  # :validatable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :omniauthable, :confirmable


  belongs_to :church_type, class_name: 'ChurchType'
  belongs_to :radio_station, class_name: 'RadioStation'
  belongs_to :invitation

  has_one :address, dependent: :destroy
  has_one :identity, dependent: :destroy

  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'sender_id', dependent: :destroy
  has_many :audits, class_name: 'Audit', dependent: :destroy
  has_many :favorites, class_name: 'Favorite', dependent: :destroy
  has_many :plays, class_name: 'Play', dependent: :destroy

  has_many :favorite_podcasts, through: :favorites, source: :favoritable, source_type: 'Podcast'
  has_many :favorite_episodes, through: :favorites, source: :favoritable, source_type: 'Episode'
  has_many :favorite_articles, through: :favorites, source: :favoritable, source_type: 'Article'

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :audits

  has_attached_file :background_pic
  has_attached_file :profile_pic, default_url: ':default_user', styles: { normal: '200x200#' }

  before_create :create_address


  # Default Devise Validation ( devise module :validatable )
  # ------------------------
  validates_presence_of   :email, if: :email_changed?
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of     :email, with: Devise::email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise::password_length, allow_blank: true

  def password_required?
    !password.nil? || !password_confirmation.nil?
  end
  # ------------------------


  validates_length_of :language, maximum: 255, too_long: 'Pick a shorter name'
  validates_length_of :church_name, maximum: 255, too_long: 'Pick a shorter name'
  validates :username, uniqueness: true, allow_blank: true
  validates :gender, inclusion: { in: ['Male', 'Female'] }, allow_blank: true
  validates :christian_for, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_blank: true
  validate :format_username
  validate :format_birth_date

  validates_attachment_content_type :background_pic, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\Z/



  def full_name
    "#{first_name} #{last_name}".strip.presence
  end

  def full_name_with_email
    full_name || email
  end

  def update_tracked_fields(request)
    super
    audits.build(action: 'login', ip: last_sign_in_ip) if last_sign_in_at_changed?
  end

  # NOTE: This method is return additional values when we call
  #
  # respond_to current_user
  def as_json(options = {})
    result = super
    result['address'] = self.address
    result['profile_pic'] = self.profile_pic.url(:normal)
    result['background_pic'] = self.background_pic.url if self.background_pic.present?
    result['full_name']      = self.full_name
    result['church_type'] = self.church_type.try(:name)

    result['year']        = self.birth_date.try(:year)
    result['month']       = self.birth_date.try(:month)
    result['day']         = self.birth_date.try(:day)

    result['unconfirmed_email'] = self.unconfirmed_email

    return result
  end

  def format_username
    if self.username_changed?
      precompiled_slug = self.username.downcase.parameterize

      if User.where(slug: precompiled_slug).where.not(username: self.username).any?
        errors.add( :username, 'Already has such slug')
      end
    end
  end

  def format_birth_date
    if self.year && self.month && self.day
      self.errors.add( :day, 'Date is invalid') unless convert_birth_date
    end
  end

  def convert_birth_date
    begin
      civil_date = Date.civil( self.year.to_i, self.month.to_i, self.day.to_i )
      raise ArgumentError if civil_date > Date.today
      self.birth_date = civil_date
    rescue ArgumentError
      false
    end
  end


  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end

  # Note: We should remember user by default.
  def remember_me
    true
  end

  # Note: We should create address for new users
  def create_address
    build_address
  end

  def christian_for=(num)
    num.gsub!(',', '.') if num.is_a?(String)
    self[:christian_for] = num
  end
end
