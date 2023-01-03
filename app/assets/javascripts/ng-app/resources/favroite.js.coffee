angular.module("Meek").factory "Favorite", ($resource) ->
  $resource "/api/user/favorites/:id", { format: 'json' }