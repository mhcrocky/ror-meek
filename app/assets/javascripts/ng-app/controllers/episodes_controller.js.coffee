angular.module("Meek").controller "EpisodesController", (
  $rootScope,
  $scope,
  $stateParams,
  $sce

  Category
  Episode
  Podcast

  ApplicationService
) ->

  $scope.category = Category.get({ id: $stateParams.categoryId })
  $scope.podcast = Podcast.get({ id: $stateParams.podcastId })


  $scope.episode = Episode.get({ id: $stateParams.id, podcastId: $stateParams.podcastId }, (episode) ->
    metaInformation = {
      title:          episode.meta_title
      description:    episode.meta_description
      imagePath:      episode.image
      googlebotImage: episode.googlebot
      videoUrl:       episode.stream_url if episode.video
    }
    $rootScope.head.setAllMetaInformation(metaInformation)

    $rootScope.head.setMetaTag({ name: 'robots', content: 'noindex' }) if episode.noindex

    $scope.htmlSafeTranscription = $sce.trustAsHtml(episode.transcription)
    $scope.schema_content = $sce.trustAsHtml(episode.schema)
  )
