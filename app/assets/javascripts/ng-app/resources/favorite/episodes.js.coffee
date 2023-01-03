angular.module("Meek").factory "FavoriteEpisodes", ($resource) ->
  $resource "/api/user/favorite/episodes", { format: 'json' }
