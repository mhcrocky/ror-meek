angular.module('Meek').factory 'TrendEpisodes', ($resource) ->
  $resource '/api/trends/episodes', { format: 'json' }
