angular.module('Meek').factory 'TrendPosts', ($resource) ->
  $resource '/api/trends/posts', { format: 'json' }
