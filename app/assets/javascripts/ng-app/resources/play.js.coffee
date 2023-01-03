angular.module("Meek").factory "Play", ($resource) ->
  $resource "/api/play", { format: 'json' },
    {
      'update': { method:'PUT' }
    }
