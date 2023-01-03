class Invitation < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  has_one :recipient, class_name: 'User'


  validates :recipient_email, :subject, :message, :friend_name, presence: true
  validates :recipient_email, format: { with: Devise::email_regexp }
  validates :recipient_email, uniqueness: { scope: :sender_id, message: 'You have already sent invitation' }
  validate  :recipient_is_not_registered


  before_create :generate_token


  private
  def recipient_is_not_registered
    if User.find_by(email: recipient_email)
      errors.add(:recipient_email, 'Is already registered')
    end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
