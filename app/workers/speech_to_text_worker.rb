class SpeechToTextWorker
  @queue = 'speech_to_text'

  def self.perform(episode_id)
    SpeechToTextConverter.new(episode_id).set_transcription_value
  end
end
