angular.module("Meek").controller "HomeController", (
  $state
  $rootScope
  $scope
  $sce

  Background

  TrendEpisodes
  TrendLatests
  TrendPodcastsToTry

  RecentEpisodes
  
  AuthenticationService
  ApplicationService
  Auth
) ->

  $rootScope.head.setAllMetaInformation()
  $scope.selectedTab = 'stations'
