angular.module("Meek").controller "ProfileController", (
  $rootScope
  $scope
  $state
  $sce
  $stateParams

  RecentStationPlays
  RecentEpisodePlays

  FavoritePodcasts
  FavoriteEpisodes

  ApplicationService
  DurationService
  Auth
  Layout
) ->

  $rootScope.head.setTitle('Account')

  Auth.currentUser().then (user) ->
    if user.slug == $stateParams.id
      $scope.background = "background-color: #{user.background_color}"

      if user.background_pic?
        $scope.background = "background-image: url(#{user.background_pic});"

      $scope.favoriteActive = null
      $scope.recentActive   = null

      $scope.favoritePodcasts = FavoritePodcasts.query()
      $scope.favoriteEpisodes = FavoriteEpisodes.query( ->
        $scope.favoriteActive = 'episode'
      )

      $scope.recentEpisodes = RecentEpisodePlays.query( ->
        $scope.recentActive = 'episode'
      )

      $scope.favoriteActiveUpdate = (type) =>
        return if type == $scope.favoriteActive
        $scope.favoriteActive = type

      $scope.recentActiveUpdate = (type) =>
        return if type == $scope.recentActive
        $scope.recentActive = type


      $scope.playFavoriteMedia = (data) ->
        if $scope.favoriteActive == 'episode'
          $rootScope.player.startPodcast(data.podcast, data)

        if $scope.favoriteActive == 'podcast'
          $rootScope.player.startPodcast(data, data.current_episode)

      $scope.playRecentMedia = (data) ->
        if $scope.recentActive == 'episode'
          $rootScope.player.startPodcast(data.podcast, data.episode, data.stopped_at)


      $scope.slickConfig =
        enabled: true
        infinite: false
        dots: false
        slidesToScroll: 1
        slidesToShow: 5
        responsive: [
          {
            breakpoint: 1500
            settings: {
              slidesToShow: 4
            }
          }
          {
            breakpoint: 1200
            settings: {
              slidesToShow: 3
            }
          }
          {
            breakpoint: 667
            settings: {
              slidesToShow: 2
              arrows: false
            }
          }
          {
            breakpoint: 400
            settings: {
              slidesToShow: 1
              arrows: false
            }
          }
        ]

    else
      $state.go('home')

  , ->
    $state.go('home')
