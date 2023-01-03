angular.module("Meek").controller "FavoriteAllController", (
  $rootScope
  $scope

  FavoritePodcasts
  FavoriteEpisodes
  FavoriteArticles

  ApplicationService
) ->

  $rootScope.head.setTitle('Favorite All')

  $scope.favorite_type = 'all'

  $scope.podcasts = FavoritePodcasts.query()
  $scope.episodes = FavoriteEpisodes.query()
  $scope.articles = FavoriteArticles.query()
