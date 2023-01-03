require 'rails_helper'

describe PodcastEpisodeFeeder do
  let(:media_rss) { Rails.root.join('spec', 'support', 'rss', 'media_rss.xml').to_s }
  let(:secondary_media_rss) { Rails.root.join('spec', 'support', 'rss', 'secondary_media_rss.xml').to_s }
  let(:media_rss_with_changes) { Rails.root.join('spec', 'support', 'rss', 'media_rss_with_changes.xml').to_s }
  let(:media_rss_with_deletions) { Rails.root.join('spec', 'support', 'rss', 'media_rss_with_deletions.xml').to_s }

  before do
    media_rss_dbl = double('Media RSS', body: File.open(media_rss, 'rb').read)
    secondary_media_rss_dbl = double('Media RSS', body: File.open(secondary_media_rss, 'rb').read)
    media_rss_with_changes_dbl = double('Media RSS', body: File.open(media_rss_with_changes, 'rb').read)
    media_rss_with_deletions_dbl = double('Media RSS', body: File.open(media_rss_with_deletions, 'rb').read)

    allow(HTTParty).to receive(:get).with(media_rss).and_return(media_rss_dbl)
    allow(HTTParty).to receive(:get).with(secondary_media_rss).and_return(secondary_media_rss_dbl)
    allow(HTTParty).to receive(:get).with(media_rss_with_changes).and_return(media_rss_with_changes_dbl)
    allow(HTTParty).to receive(:get).with(media_rss_with_deletions).and_return(media_rss_with_deletions_dbl)
  end

  let(:podcast_category) { create :category, kind: 1 }

  describe 'valid RSS feed' do
    let(:podcast) { create :podcast,
                            category_id: podcast_category.id,
                            feed_url: media_rss }

    it 'creates new episodes' do
      expect { described_class.import!(podcast.id) }.to change {
        podcast.episodes.count
      }.from(0).to(3)
    end

    it 'creates episode with proper data' do
      described_class.import!(podcast.id)

      episode = podcast.episodes.first

      expect(episode.name).to eq('Husbands, your family life determines the success of your calling')
      expect(episode.release_date).to eq('Mon, 22 Feb 2016 05:01:00 +0000'.to_date)
      expect(episode.duration).to eq(446)
      expect(episode.stream_url).to eq('http://traffic.libsyn.com/amosjohnsonjr/02222016.mp3')
    end
  end

  describe 'several feeds' do
    let(:podcast) { create :podcast,
                           category_id: podcast_category.id,
                           feed_url: media_rss,
                           secondary_feed_url: secondary_media_rss }

    it 'creates episodes from both feeds' do
      expect { described_class.import!(podcast.id) }.to change {
        podcast.episodes.count
      }.from(0).to(5)
    end

    it 'creates episode with proper data' do
      described_class.import!(podcast.id)

      episode = podcast.episodes.last

      expect(episode.name).to eq('My MoneyLife for Thursday, Mar 10, 2016')
      expect(episode.release_date).to eq('Thu, 3 Mar 2016 17:42:24 -0500'.to_date)
      expect(episode.stream_url).to eq('http://www.crown.org/media_dl/cfm_mml_20160310.mp3')
    end
  end

  describe 'upload feed with changes' do
    let(:podcast) { create :podcast,
                            category_id: podcast_category.id,
                            feed_url: media_rss }

    it 'updates datas if already imported episode has been changed in the feed' do
      described_class.import!(podcast.id)

      expect(podcast.episodes.first.name).to eq('Husbands, your family life determines the success of your calling')

      podcast.update_attributes(feed_url: media_rss_with_changes)
      described_class.import!(podcast.id)

      expect(podcast.episodes.first.name).to eq('Wives, your family life determines the success of your life!')
    end
  end

  describe 'upload feed without already existing podcast' do
    let(:podcast) { create :podcast,
                            category_id: podcast_category.id,
                            feed_url: media_rss }

    it 'keeps the old records' do
      described_class.import!(podcast.id)

      expect(podcast.episodes.where(name: 'Husbands, your family life determines the success of your calling')).to exist

      podcast.update_attributes(feed_url: media_rss_with_deletions)
      described_class.import!(podcast.id)

      expect(podcast.episodes.where(name: 'Husbands, your family life determines the success of your calling')).to exist
    end
  end

  describe 'Touch category after import' do
    let(:podcast) { create :podcast,
                            category_id: podcast_category.id,
                            feed_url: media_rss }

    # We create excess queries to DB while importing.
    it 'should not touch category (callbacks) while import' do
      expect { described_class.import!(podcast.id) }.to_not change {
        podcast_category.updated_at
      }
    end
  end

end
