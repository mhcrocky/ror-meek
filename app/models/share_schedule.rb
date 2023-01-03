class ShareSchedule < ActiveRecord::Base
  validates :hours, :minutes, presence: true

  validates :hours, inclusion: { in: 0..23 }
  validates :minutes, inclusion: { in: 0..59 }

  after_commit :trigger_cron

  def publish_time
    # HH:MM
    format('%02d', self.hours.to_s) + ':' + format('%02d', self.minutes.to_s)
  end


  def trigger_cron
    `RAILS_ENV=#{Rails.env} bundle exec whenever --update-crontab meek --set environment=#{Rails.env}`
  end

  # Array for whenever
  def self.whenever_time_array
    self.all.map(&:publish_time)
  end
end
