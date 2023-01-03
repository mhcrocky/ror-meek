json.array! @favorite_articles do |article|
    json.partial!('api/articles/article', article: article)
  
    json.for_preview do
      json.category_name   article.category.name
      json.category_path   "article/#{article.category.slug}"
      json.name            article.name
      json.description     article.short_description
      json.image           article.normal_path
      json.path            "article/#{article.category.slug}/#{article.slug}"
    end
  end
