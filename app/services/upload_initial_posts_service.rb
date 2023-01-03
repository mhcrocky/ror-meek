class UploadInitialPostsService
  def self.initial_posts(dump, article)
    keys = [:name, :body, :release_date, :short_description, :stream_url]
    post_attributes = []
    parsed_csv_file = CSV.read(dump, col_sep: '|')
    parsed_csv_file.each do |el|
      post_attributes << [keys, el].transpose.to_h
    end
    create_posts_from(post_attributes, article)
  end

  def self.create_posts_from(post_attributes, article)
    post_attributes.each do |post_attribute|
      post = Post.new
      post.assign_attributes(with_default_attributes(post_attribute.compact, article)) 
      post.save
    end
  end

  def self.with_default_attributes(item, article)
    item.merge(
      article_id: article.id,
      noindex: article.noindex
    )
  end
end
