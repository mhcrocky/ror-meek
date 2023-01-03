require 'htmlentities'

json.(post, *post.attributes.keys)
json.name        post.name
json.description post.article.short_description
json.path        post.stream_url
json.released_at post.released_at
