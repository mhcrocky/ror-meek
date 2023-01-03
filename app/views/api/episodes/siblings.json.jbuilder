if @next_episode
  json.next_episode do
    json.slug @next_episode.slug
    json.name @next_episode.name
  end
end

if @prev_episode
  json.prev_episode do
    json.slug @prev_episode.slug
    json.name @prev_episode.name
  end
end
