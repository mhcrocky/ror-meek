angular.module("Meek").controller "FavoritePodcastsController", (
  $rootScope
  $scope

  FavoritePodcasts

  ApplicationService
) ->

  $rootScope.head.setTitle('Favorite Podcasts')

  $scope.favorite_type = 'podcasts'

  $scope.podcasts = FavoritePodcasts.query()
