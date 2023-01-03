require 'htmlentities'

json.(article, *article.attributes.keys)
json.image     article.normal_path
json.googlebot article.image(:googlebot)
json.wallpaper article.wallpaper_path
json.path      "article/#{article.category.slug}/#{article.slug}"

json.current_post do
  json.partial!('api/posts/post', post: article.posts.ordered.first) if article.posts.ordered.first
end

json.for_preview do
  json.category_name   article.category.name
  json.category_path   "article/#{article.category.slug}"
  json.name            article.name
  json.description     article.short_description
  json.image           article.normal_path
  json.path            "/article/#{article.category.slug}/#{article.slug}"
end

