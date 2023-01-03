angular.module('Meek').factory 'Search', ($resource) ->
  $resource '/api/search/searches', { format: 'json' }
