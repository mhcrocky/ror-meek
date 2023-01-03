angular.module("Meek").controller "FavoriteEpisodesController", (
  $rootScope
  $scope

  FavoriteEpisodes

  ApplicationService
) ->

  $rootScope.head.setTitle('Favorite Episodes')

  $scope.favorite_type = 'episodes'

  $scope.episodes = FavoriteEpisodes.query()
