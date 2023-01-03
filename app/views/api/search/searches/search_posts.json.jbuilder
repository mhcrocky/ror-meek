json.data do
  json.array! @paginated_results do |post|
    json.partial!('api/posts/post', post: post)

    json.article do
      json.(post.article, *post.article.attributes.keys)
      json.short_description post.article.short_description
      json.image post.article.normal_path
    end

    json.for_preview do
      json.name                   post.name
      json.category_name          post.article.category.name
      json.description            post.article.short_description
      json.image                  post.article.normal_path
      json.category_path          "article/#{post.article.category.slug}"
      json.path                   post.stream_url
    end
  end
end

json.next_page @paginated_results.next_page
