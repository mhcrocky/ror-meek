angular.module("Meek").factory "Country", ($resource) ->
  $resource "/api/countries/:id", { format: 'json' }, {
    get: { cache: true }
  }