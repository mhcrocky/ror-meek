class PlayerSection < SitePrism::Section
  element :image, '.player-song-card img'
  element :title, '.player-song-card .song-card-title'
end
