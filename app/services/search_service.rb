class SearchService
  attr_reader :phrase

  # Current service returns array of Episodes/Podcasts/RadioStations with preloaded categories.
  # Resulted array is sorted by ( depends from ) ts_rank
  def initialize(phrase)
    @phrase = phrase
    @query = prepare_phrase(phrase)
  end

  def podcasts
    result = Podcast.find_by_sql(sql_podcasts(@query))
    include_categories(result)
  end

  def episodes
    result = Episode.find_by_sql(sql_episodes(@query))
    include_categories(result)
  end

  def articles
    result = Article.find_by_sql(sql_articles(@query))
    include_categories(result)
  end

  def posts
    result = Post.find_by_sql(sql_posts(@query))
    include_categories(result)
  end

  private

  def include_categories(result)
    ActiveRecord::Associations::Preloader.new.preload(result, :category)
    result
  end

  def sql_podcasts(query)
    <<-SQL
      SELECT *, ts_rank(p_search.document, to_tsquery('english', '#{query}')) AS rank

      FROM (
        SELECT p.*,
               setweight(to_tsvector('english', p.name), 'A') ||
               setweight(to_tsvector('english', p.h1), 'B') ||
               setweight(to_tsvector('english', p.short_description), 'C') ||
               setweight(to_tsvector('english', p.tags), 'D') AS document
        FROM podcasts p
      ) p_search

      WHERE p_search.document @@ to_tsquery('english', '#{query}')
      ORDER BY rank DESC;
    SQL
  end

  def sql_episodes(query)
    <<-SQL
      SELECT *, ts_rank(p_search.document, to_tsquery('english', '#{query}')) AS rank
      FROM (
        SELECT ep.*,
               setweight(to_tsvector('english', ep.h1), 'A') ||               
               setweight(to_tsvector('english', ep.tags), 'C') AS document
        FROM episodes ep
      ) p_search
      WHERE p_search.document @@ to_tsquery('english', '#{query}')

      UNION

      SELECT ep.*, '1' AS document, '1' AS rank
      FROM episodes ep
      WHERE ep.transcription LIKE '%#{phrase}%'

      ORDER BY rank DESC;
    SQL
  end

  def sql_articles(query)
    <<-SQL
      SELECT *, ts_rank(a_search.document, to_tsquery('english', '#{query}')) AS rank

      FROM (
        SELECT a.*,
              setweight(to_tsvector('english', a.name), 'A') ||
              setweight(to_tsvector('english', a.description), 'B') ||
              setweight(to_tsvector('english', a.short_description), 'C') ||
              setweight(to_tsvector('english', a.tags), 'D') AS document
        FROM articles a
      ) a_search

      WHERE a_search.document @@ to_tsquery('english', '#{query}')
      ORDER BY rank DESC; 
    SQL
  end

  def sql_posts(query)
    <<-SQL
      SELECT *, ts_rank(pst_search.document, to_tsquery('english', '#{query}')) AS rank

      FROM (
        SELECT pst.*,
              setweight(to_tsvector('english', pst.name), 'A') ||
              setweight(to_tsvector('english', pst.body), 'B') ||
              setweight(to_tsvector('english', pst.short_description), 'C') ||
              setweight(to_tsvector('english', pst.tags), 'D') AS document
        FROM posts pst
      ) pst_search

      WHERE pst_search.document @@ to_tsquery('english', '#{query}')
      ORDER BY rank DESC;
    SQL
  end

  def  prepare_phrase(phrase)
    sanitized_phrase = phrase.squish.gsub(/[^A-Za-z \-]/, '').split
    # http://www.postgresql.org/docs/9.1/static/datatype-textsearch.html

    # This query will match any word in a tsvector that begins with "super". Note that prefixes are first processed by text search configurations, which means this comparison returns true:
    #
    # SELECT to_tsvector( 'postgraduate' ) @@ to_tsquery( 'postgres:*' );
    #  ?column?
    # ----------
    #  t
    # (1 row)
    #
    # because postgres gets stemmed to postgr:
    sanitized_phrase.map{|x| "#{x}:*"}.join(' & ')
  end
end
