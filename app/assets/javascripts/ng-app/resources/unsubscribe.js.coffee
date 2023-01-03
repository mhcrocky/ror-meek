angular.module('Meek').factory 'Unsubscribe', ($resource) ->
  $resource '/api/unsubscribe', { format: 'json' },
    {
      'update': { method:'PUT' }
    }
