require 'rails_helper'

describe PublisherQueueService do
  describe '#add_new_episodes_to_publish_queue' do
    context 'check with autopublish_new' do
      let(:podcast_without_autopublish) { create :podcast, autopublish_new: false }
      let(:podcast_with_autopublish) { create :podcast, autopublish_new: true }

      it 'do not calls #share_episodes if podcasts autopublish_new is false' do
        expect(described_class).to_not receive(:share_episodes)

        described_class.add_new_episodes_to_publish_queue(podcast_without_autopublish)
      end

      it 'calls #share_episodes with only new podcasts' do
        expect(described_class).to receive(:share_episodes)

        described_class.add_new_episodes_to_publish_queue(podcast_with_autopublish)
      end
    end

    context 'non_shared' do
      let(:podcast) { create :podcast, autopublish_new: true }

      let!(:episode_shared) { create :episode, podcast: podcast, already_shared: true, release_date: Date.current }
      let!(:episode_non_shared) { create :episode, podcast: podcast, already_shared: false, release_date: Date.current }

      it 'gets episodes' do
        expect(described_class).to receive(:share_episodes).with([episode_non_shared], ShareQueue.publish_types[:from_new])

        described_class.add_new_episodes_to_publish_queue(podcast)
      end
    end

    context 'only_new_episodes' do
      let(:podcast) { create :podcast, autopublish_new: true }

      let!(:episode_new) { create :episode, podcast: podcast, already_shared: false, release_date: Date.current }
      let!(:episode_old) { create :episode, podcast: podcast, already_shared: false, release_date: Date.current - 100.days}

      it 'gets episodes' do
        expect(described_class).to receive(:share_episodes).with([episode_new], ShareQueue.publish_types[:from_new])

        described_class.add_new_episodes_to_publish_queue(podcast)
      end
    end
  end

  describe '#add_old_episodes_to_publish_queue' do

    context 'check with autopublish_old' do
      let(:podcast_without_autopublish) { create :podcast, autopublish_old: false }
      let(:podcast_with_autopublish) { create :podcast, autopublish_old: true, autopublish_old_date: '2013/11/20' }

      it 'do not calls #share_episodes if podcasts autopublish_old is false' do
        expect(described_class).to_not receive(:share_episodes)

        described_class.add_old_episodes_to_publish_queue(podcast_without_autopublish)
      end

      it 'calls #share_episodes with only new podcasts' do
        expect(described_class).to receive(:share_episodes)

        described_class.add_old_episodes_to_publish_queue(podcast_with_autopublish)
      end
    end

    context 'non_shared' do
      let(:podcast) { create :podcast, autopublish_old: true, autopublish_old_date: '2013/11/20' }

      let!(:episode_shared) { create :episode, podcast: podcast, already_shared: true, release_date: '2013/11/20'.to_date }
      let!(:episode_non_shared) { create :episode, podcast: podcast, already_shared: false, release_date: '2013/11/20'.to_date }

      it 'gets episodes' do
        expect(described_class).to receive(:share_episodes).with([episode_non_shared], ShareQueue.publish_types[:from_old])

        described_class.add_old_episodes_to_publish_queue(podcast)
      end
    end

    context 'with_publish_date' do
      let(:podcast) { create :podcast, autopublish_old: true, autopublish_old_date: '2013/11/20' }

      let!(:episode_with_correct_data) { create :episode, podcast: podcast, already_shared: false, release_date: '2013/11/20'.to_date }
      let!(:episode_with_incorrect_data) { create :episode, podcast: podcast, already_shared: false, release_date: '2013/11/21'.to_date }

      it 'gets episodes' do
        expect(described_class).to receive(:share_episodes).with([episode_with_correct_data], ShareQueue.publish_types[:from_old])

        described_class.add_old_episodes_to_publish_queue(podcast)
      end
    end

  end

  describe '#share_episodes' do
    let(:podcast) { create :podcast }
    let!(:ep) { create :episode, podcast: podcast }

    it 'returns false if episodes are empty' do
      expect( described_class.share_episodes([], ShareQueue.publish_types[:from_new]) ).to be_falsy
    end

    it 'updates already_shared to true' do
      expect(ep.already_shared).to be_falsy

      described_class.share_episodes(podcast.episodes, ShareQueue.publish_types[:from_new])

      expect(ep.reload.already_shared).to be_truthy
    end

    it 'creates new ShareQueue' do
      expect{
        described_class.share_episodes(podcast.episodes, ShareQueue.publish_types[:from_new])
      }.to change {
        ShareQueue.count
      }.by(1)
    end

    it 'creates ShareQueue for episode with proper type' do
      expect(ep.share_queues).to eq []

      described_class.share_episodes(podcast.episodes, ShareQueue.publish_types[:from_old])

      expect(ep.reload.share_queues.first.publish_type).to eq 'from_old'
    end
  end
end
