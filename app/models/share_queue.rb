class ShareQueue < ActiveRecord::Base
  enum publish_type: { from_new: 0, from_old: 1 }

  belongs_to :episode

  after_create :recache_episode_page

  scope :ordered, -> { order(id: :asc) }
  scope :without_publish_date, -> { where(published_at: nil) }
  scope :with_publish_date, -> { where.not(published_at: nil) }

  validates :publish_type, inclusion: { in: ShareQueue.publish_types.keys }

  def publish_episode!
    return false if self.episode.blank?

    self.update_attributes(published_at: DateTime.current)

    PublisherService.call(self.episode)
  end


  def recache_episode_page
    # Note: We should manualy recache episode page.
    # Becase prerendereer.io service makes recache onece per 7 day.
    # So prerenderer service may not be able to do mock up of the page.
    # In this case FB publisher will publish blank page.
    PrerendererRecacheService.new(self.episode.id).recache
  end
end
