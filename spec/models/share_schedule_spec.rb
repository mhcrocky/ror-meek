require "rails_helper"

describe ShareSchedule do
  describe '.publish_time' do
    let(:share_schedule) { create :share_schedule }

    it 'return formatted time' do
      time_in_format = DateTime.new(2001,1,1,share_schedule.hours,share_schedule.minutes,1).strftime("%H:%M")
      expect(share_schedule.publish_time).to eq(time_in_format)
    end
  end

  describe '#whenever_time_array' do
    before do
      described_class.skip_callback(:save, :after, :trigger_cron)

      create :share_schedule, hours: '1', minutes: '1'
      create :share_schedule, hours: '9', minutes: '15'
      create :share_schedule, hours: '22', minutes: '55'

      described_class.set_callback(:save, :after, :trigger_cron)
    end

    it 'returns array of publish time' do
      expect(described_class.whenever_time_array).to match_array ['01:01', '09:15', '22:55']
    end
  end
end
