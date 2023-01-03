angular.module("Meek").factory "Category", ($resource) ->
  $resource "/api/categories/:id", { format: 'json' }, {
    get: { cache: true }
  }
