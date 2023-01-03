class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :media, polymorphic: true

  validates :media_id, presence: true

  delegate :duration, to: :media

  scope :for_user, -> (id) { where(user_id: id) }

  scope :episodes_only, -> { where(media_type: 'Episode') }
  scope :stations_only, -> { where(media_type: 'RadioStation') }

  scope :last_ten_days, -> { where(created_at: 10.days.ago..Time.now) }
  scope :get_top, -> (num) { group('media_id').count.max_by(num) {|x| x[1] }.map{|x| x[0]} }
end
