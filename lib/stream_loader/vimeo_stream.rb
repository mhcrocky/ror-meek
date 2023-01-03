class StreamLoader::VimeoStream

  def initialize(url)
    @stream_url = url
    return nil if @stream_url.blank?

    @user_name = get_user_name

    authenticate!
  end

  def get_feed_episodes
    feed_episodes = []

    vimeo_rss.each do |video|
      next unless video['privacy']['view'] == 'anybody'

      feed_episodes.push({
        video:              true,
        name:               video['name'],
        release_date:       video['release_time'].to_date,
        duration:           video['duration'],
        stream_url:         video['link'],
        short_description:  video['description'] || ''
      })
    end

    feed_episodes
  end

  def is_valid?
    return false if @stream_url.blank?

    response = get_videos(page: 1, per_page: 1)
    response['error'].blank?
  end

  private

  def authenticate!
    url = 'https://api.vimeo.com/oauth/authorize/client'
    headers = {'Authorization' => "basic #{ENV.fetch('VIMEO_ACCESS_CODE')}"}
    body = {'grant_type' => 'client_credentials'}

    response = HTTParty.post(url, headers: headers, body: body)

    @access_token = response['access_token']
  end

  def get_user_name
    @stream_url.split('https://vimeo.com/')[1]
  end

  def vimeo_rss
    rss = []

    index = 0
    next_page = nil

    begin
      break if index > 4 # For now. ( Because 5 cause "We're like, soooo popular. Please try again in a few minutes.")

      index += 1
      response = get_videos(page: index)

      next_page = response['paging']['next']
      rss += response['data']
    end while next_page.present?

    rss
  end

  def get_videos(page:, per_page: 100) # Max per_page is 100
    url = "https://api.vimeo.com/users/#{@user_name}/videos?per_page=#{per_page}&page=#{page}"
    headers = { 'Authorization' => "Bearer #{@access_token}" }

    response = HTTParty.get(url, headers: headers)
    JSON.parse(response)
  end
end
