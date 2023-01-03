class FfprobeService
  # Note: Calculate the duration of the Stream URL in seconds.

  def self.calculate_audio_duration(url)
    return nil unless valid_uri?(url)

    # "-show_entries format=duration": Get entries of a field named duration inside a section named format
    # "-v quiet": Don't output anything else but the desired raw data value
    # "-print_format": Use a certain format to print out the data
    # "print_section=0": Do not print the section name
    # ——————————
    # Example
    # ffprobe -i http://feeds-tmp.soundcloud.com/stream/239698145.mp3 -show_entries format=duration -v quiet -print_format csv=print_section=0
    # ffprobe -i http://podcast.ransomedheart.com.s3.amazonaws.com/2011/fathered_by_god_pt_6_sage.mp3 -show_entries format=duration -v quiet -print_format csv=print_section=0


    # NOTE: ffprobe does not work for 2.8.5 version ( We add sleep 4 and kill for this purpose )
    output = `ffprobe -i "#{url}" -show_entries format=duration -v quiet -print_format csv=print_section=0 & sleep 4; kill $!`

    output = output.chomp
    return nil if output.blank?

    output.to_i
  end


  def self.valid_uri?(string)
    uri = URI.parse(string)

    return false if uri.path.end_with?(".pdf")
    return false if %w( http https ).exclude?(uri.scheme)

    true
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end
