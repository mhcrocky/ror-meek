class ArticlePostFeeder
  def self.import!(article_id)
    _article = Article.find_by(id: article_id)
    return false if _article.nil?

    new(_article)
    PublisherQueueService.add_new_posts_to_publish_queue(_article)
    PublisherQueueService.add_old_posts_to_publish_queue(_article)

    true
  end

  def initialize(article)
    @article = article
    @article_posts = article.posts

    @text_rss_stream = StreamLoader::TextRssStream.new(@article.feed_url)

    self.start_import
  end

  def start_import
    full_feed = []
    full_feed += @text_rss_stream.get_feed_posts if @text_rss_stream.is_valid?

    ActiveRecord::Base.no_touching do
      if full_feed.any?
        set_article_as_broken(false)
        create_posts_from(full_feed)
      else
        set_article_as_broken(true)
      end
    end
  end

  private

  def create_posts_from(feed_posts)
    feed_posts.each do |post_attributes|
      post = @article_posts.to_a.find { |ep| ep[:stream_url] == post_attributes[:stream_url] } || Post.new
      post.assign_attributes(with_default_attributes(post_attributes.compact))

      if post.changed.any? && post.valid?
        post.save
      end
    end
  end

  def with_default_attributes(item)
    item.merge(
      article_id: @article.id,
      noindex: @article.noindex
    )
  end

  def set_article_as_broken(bool)
    @article.update_attributes(feed_is_broken: bool) if @article.feed_is_broken != bool
  end
end
