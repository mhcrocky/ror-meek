require "google/cloud/storage"
require "google/cloud/speech"

class SpeechToTextConverter
  attr_reader :episode

  def initialize(episode_id)
    @episode = Episode.find(episode_id)
  end

  def set_transcription_value
    return if episode.video == true

    tempfile = Down.download(episode.stream_url, max_redirects: ENV.fetch('EPISODES_STREAM_MAX_REDIRECT_COUNT', 5).to_i)
    operation = speech_client.long_running_recognize(speech_config, speech_audio_config(gs_file(tempfile).to_gs_url))
    tempfile.close
    operation.wait_until_done!

    raise operation.results.message if operation.error?

    results = operation.response.results
    @gs_file.delete

    episode.update(transcription: parse_results(results))
  end

  private

  def gs_file(tempfile)
    @gs_file = bucket.create_file tempfile.path, "#{SecureRandom.hex(16)}.mp3"
  end

  def storage
    @storage ||= Google::Cloud::Storage.new(
      project_id: ENV.fetch('STORAGE_PROJECT'),
      credentials: JSON.parse(ENV.fetch('GOOGLE_API_CREDS'))
    )
  end

  def bucket
    @bucket ||= storage.bucket ENV.fetch('STORAGE_BUCKET')
  end

  def speech_client
    @speech_client ||= Google::Cloud::Speech.new(
      version: :v1p1beta1,
      credentials: JSON.parse(ENV.fetch('GOOGLE_API_CREDS'))
    )
  end

  def speech_config
    { 
      encoding:          :MP3,
      sample_rate_hertz: 16_000,
      language_code:     "en-US",
      enable_automatic_punctuation: true
    }
  end

  def speech_audio_config(gs_url)
    { uri: gs_url }
  end

  def parse_results(results)
    "<p>#{results.map(&:alternatives).map(&:first).map(&:transcript).join}</p>"
  end
end

