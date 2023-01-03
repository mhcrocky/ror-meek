# https://github.com/angular-ui/ui-router/issues/1159
# http://stackoverflow.com/questions/20230691/injecting-state-ui-router-into-http-interceptor-causes-circular-dependency

angular.module("Meek").factory 'httpInterceptor', [
  '$injector'
  '$q'
  ($injector, $q) ->
    success = (response) ->
      url = response.config.url
      page = if response.config.params && response.config.params.page then response.config.params.page else null
      if url.startsWith '/api/'
        window._bridge.redux.dispatch
          type: 'ANGULAR_RESOURCES__UPDATE'
          resource: url + (if page then '?page=' + page else '')
          value: response.data
      response || $q.when(response)

    error = (response) ->
      if response.status == 404
        $injector.get('$state').go('404', null, location: false)

      $q.reject(response)

    {
      'response': success,
      'responseError': error
    }
]
