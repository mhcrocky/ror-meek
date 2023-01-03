angular.module("Meek").factory "Podcast", ($resource) ->
  $resource "/api/podcasts/:id", { format: 'json' }, {
    get: { cache: true }
  }
