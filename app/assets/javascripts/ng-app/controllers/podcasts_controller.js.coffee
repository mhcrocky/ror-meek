angular.module("Meek").controller "PodcastsController", ($sce
  $rootScope
  $scope
  $stateParams
  $timeout
  Category
  Episode
  Podcast
  ApplicationService) ->
  $scope.category = Category.get({ id: $stateParams.categoryId })

  $scope.podcast = Podcast.get({ id: $stateParams.id }, (podcast) ->
    $rootScope.head.setAllMetaInformation({
      title: podcast.meta_title,
      description: podcast.meta_description,
      imagePath: podcast.image,
      googlebotImage: podcast.googlebot
    })

    $scope.htmlSafeDescription = $sce.trustAsHtml(podcast.description)
    $scope.schema_content = $sce.trustAsHtml(podcast.schema)
  )

  $scope.searchQuery = { text: '' }
  $scope.pages = []
  $scope.episodes = []
  $scope.episodesCount = null
  $scope.episodesNextPage = null
  $scope.episodeActive = null

  $scope.loadMoreEpisodes = (page, searchQuery) ->
    return if !page

    if page == 1
      $scope.pages = []
      $scope.episodes = []

    Episode.get({ podcastId: $stateParams.id, page: page, search_query: searchQuery }, (response) ->
      $scope.pages[page] = response.data
      $scope.episodes = $scope.pages.flatten()
      $scope.episodesCount = response.pagination.total
      $scope.episodesNextPage = response.pagination.next
    )

  $scope.loadMoreEpisodes(1)

  $scope.toggleActiveEpisode = (episode, event) ->
    event.stopPropagation()
    $timeout ->
      $scope.episodeActive = episode.id

  $scope.isActive = (episode) ->
    episode.id == $scope.episodeActive