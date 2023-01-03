angular.module("Meek").factory "Metadata", ($resource) ->
  $resource "/api/radio_stations/:id/metadata", { format: 'json' }