angular.module("Meek").factory "Background", ($resource) ->
  $resource "/api/backgrounds/:id", { format: 'json' }, {
    get: { cache: true }
  }