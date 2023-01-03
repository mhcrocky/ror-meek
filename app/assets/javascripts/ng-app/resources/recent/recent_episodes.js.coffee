angular.module('Meek').factory 'RecentEpisodes', ($resource) ->
  $resource '/api/user/recent/resent_episodes', { format: 'json' }
