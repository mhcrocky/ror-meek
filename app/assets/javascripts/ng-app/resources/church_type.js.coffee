angular.module("Meek").factory "ChurchType", ($resource) ->
  $resource "/api/church_types/:id", { format: 'json' }, {
    get: { cache: true }
  }