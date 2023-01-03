angular.module("Meek").factory "Article", ($resource) ->
  $resource "/api/articles/:id", { format: 'json' }, {
    get: { cache: true }
  }
