angular.module('Meek').factory 'RecentStationPlays', ($resource) ->
  $resource '/api/user/recent/radio_stations/:id', { format: 'json' }
