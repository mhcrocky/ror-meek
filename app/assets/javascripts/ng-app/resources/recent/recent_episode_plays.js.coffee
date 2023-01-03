angular.module('Meek').factory 'RecentEpisodePlays', ($resource, Podcast) ->
  $resource '/api/user/recent/episodes/:id', { format: 'json' }
