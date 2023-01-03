angular.module('Meek').factory 'TrendLatests', ($resource) ->
  $resource '/api/trends/latest_episodes', { format: 'json' }
