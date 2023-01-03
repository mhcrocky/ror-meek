angular.module('Meek').factory 'TrendPodcastsToTry', ($resource) ->
  $resource '/api/trends/podcasts_to_try', { format: 'json' }
