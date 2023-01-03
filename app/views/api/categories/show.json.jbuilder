json.cache! @category do
  json.partial! 'category', category: @category

  case @category.kind
    when 'podcast'
      json.podcasts_count @category.podcasts.count
      json.podcasts @category.podcasts, partial: 'api/podcasts/podcast', as: :podcast
    when 'article'
      json.article_count @category.articles.count
      json.articles @category.articles, partial: 'api/articles/article', as: :article
  end
end
