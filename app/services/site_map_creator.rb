class SiteMapCreator
  # Call a SiteMapCreator
  #
  # @return [SiteMapCreator]
  def self.call(root)
    @root = root
    @static_pages = StaticPage.all
    @radio_stations_category = Category.radio_station.includes(:radio_stations)
    @podcasts_category = Category.podcast.includes(:podcasts)

    # Check It: We have no_index flag on radio/podcast/episode so we can skip them in each
    # In this case: "if indexed_radio?(rs.slug)" will be equal "if rs.noindex?"
    @noindex_radio_stations = noindex_slugs(RadioStation)
    @noindex_podcasts = noindex_slugs(Podcast)
    @noindex_episodes = noindex_slugs(Episode)

    generate_sitemap_data
  end

  # Generate proper array of data for sitemap.xml builder
  #
  # @return [Array of Hashes]
  def self.generate_sitemap_data
    result = []

    # url: '/radio/:id'
    @radio_stations_category.each do |radio_category|
      result.push( get_url_and_date_from(radio_category, additional_url: "radio/") )

      # url: '/radio/:categoryId/:id'
      radio_category.radio_stations.each do |rs|
        result.push( get_url_and_date_from(rs, additional_url: "radio/#{radio_category.slug}/") ) if indexed_radio?(rs.slug)
      end
    end

    # url: '/:podcast_category'
    @podcasts_category.each do |podcast_category|
      result.push( get_url_and_date_from(podcast_category) )

      # url: '/:podcast_category/:id'
      podcast_category.podcasts.each do |podcast|
        result.push( get_url_and_date_from(podcast, additional_url: "#{podcast_category.slug}/") ) if indexed_podcast?(podcast.slug)

        # url: '/:podcast_category/:id/:episode'
        podcast.episodes.each do |episode|
          result.push( get_url_and_date_from(episode, additional_url: "#{podcast_category.slug}/#{podcast.slug}/") ) if indexed_episode?(episode.slug)
        end
      end
    end

    # url: '/advertise'
    # url: '/terms'
    # url: '/privacy'
    @static_pages.each do |static_page|
      result.push( get_url_and_date_from(static_page) )
    end

    result
  end

  def self.noindex_slugs(model)
    model.where(noindex: true).map(&:friendly_id)
  end

  def self.indexed_podcast?(slug)
    !@noindex_podcasts.include?(slug)
  end

  def self.indexed_radio?(slug)
    !@noindex_radio_stations.include?(slug)
  end

  def self.indexed_episode?(slug)
    !@noindex_episodes.include?(slug)
  end

  # Calculate the proper url and date for sitemap output.
  #
  # @return [Hash]
  def self.get_url_and_date_from(record, additional_url: '')
    url  = @root + additional_url + record.slug
    date = record.updated_at.xmlschema

    { url: url, date: date }
  end
end
