require "rails_helper"

describe ShareQueue do
  let(:podcast) { create :podcast }
  let(:episode) { create :episode, podcast: podcast }
  let(:share_queue) { create :share_queue, episode: episode }


  describe '.publish_episode!' do
    it 'returns false if episode blank' do
      share_queue.update_attributes(episode_id: nil)

      expect(share_queue.publish_episode!).to be_falsy
    end

    it 'calls PublisherService' do
      expect(PublisherService).to receive(:call).with(share_queue.episode)

      share_queue.publish_episode!
    end

    it 'updates published_at of instance' do
      Timecop.freeze(DateTime.current) do
        allow(PublisherService).to receive(:call).with(share_queue.episode)

        expect {
          share_queue.publish_episode!
        }.to change{ share_queue.published_at }.from(nil).to( DateTime.current )
      end
    end
  end
end
