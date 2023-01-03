angular.module("Meek").factory "RadioStation", ($resource) ->
  $resource "/api/radio_stations/:id", { format: 'json' }, {
    get: { cache: true }
  }