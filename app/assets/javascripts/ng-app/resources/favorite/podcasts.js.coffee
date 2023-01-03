angular.module("Meek").factory "FavoritePodcasts", ($resource) ->
  $resource "/api/user/favorite/podcasts", { format: 'json' }
