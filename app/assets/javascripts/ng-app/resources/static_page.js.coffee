angular.module("Meek").factory "StaticPage", ($resource) ->
  $resource "/api/static_pages/:id", { format: 'json' }, {
    get: { cache: true }
  }