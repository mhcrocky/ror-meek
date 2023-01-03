class PublisherQueueService

  def self.add_new_episodes_to_publish_queue(podcast)
    return unless podcast.autopublish_new?

    new_episodes = podcast.episodes.non_shared.only_new_episodes
    self.share_episodes(new_episodes, ShareQueue.publish_types[:from_new])
  end

  def self.add_old_episodes_to_publish_queue(podcast)
    return unless podcast.autopublish_old?

    old_episodes = podcast.episodes.non_shared.with_publish_date(podcast.autopublish_old_start_date)
    self.share_episodes(old_episodes, ShareQueue.publish_types[:from_old])
  end

  def self.share_episodes(episodes, publish_type)
    return false if episodes.empty?

    episodes.each do |episode|
      episode.share_queues.create( publish_type: publish_type, episode_name: episode.name, episode_release_date: episode.release_date )
    end
    episodes.update_all(already_shared: true)
  end

  def self.add_new_posts_to_publish_queue(article)
    return unless article.autopublish_new?

    new_posts = article.posts.non_shared.only_new_posts
    self.share_posts(new_posts, ShareQueue.publish_types[:from_new])
  end

  def self.add_old_posts_to_publish_queue(article)
    return unless article.autopublish_new?

    old_posts = article.posts.non_shared.with_publish_date(article.autopublish_old_start_date)
    self.share_posts(old_posts, ShareQueue.publish_types[:from_old])
  end

  def self.share_posts(posts, publish_type)
    return false if posts.empty?

    posts.each do |post|
      post.share_queues.create( publish_type: publish_type, post_name: post.name, post_release_date: post.release_date )
    end
    posts.update_all(already_shared: true)
  end
end
