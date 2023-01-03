class StreamValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    url = URI.parse(value)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')

    # head request of stream will throw a end of file error
    begin
      Timeout.timeout(3) { http.request_head(url.path) }
      record.errors[attribute] << 'is not a valid stream.'
    rescue => e
      record.errors[attribute] << 'is not a valid stream.' unless e.is_a? EOFError
    end
  end

end


