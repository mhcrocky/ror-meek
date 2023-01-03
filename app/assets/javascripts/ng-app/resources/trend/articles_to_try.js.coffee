angular.module('Meek').factory 'TrendArticlesToTry', ($resource) ->
  $resource '/api/trends/articles_to_try', { format: 'json' }
