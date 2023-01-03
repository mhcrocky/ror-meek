angular.module("Meek").factory "FavoriteArticles", ($resource) ->
  $resource "/api/user/favorite/articles", { format: 'json' }
