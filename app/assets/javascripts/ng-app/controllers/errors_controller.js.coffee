angular.module("Meek").controller "ErrorsController", (
  $rootScope

  ApplicationService
) ->

  # https://prerender.io/documentation/best-practices
  $rootScope.$state.go('/404')
  $rootScope.head.clearTags()
  $rootScope.head.setMetaTag({ name: 'prerender-status-code', content: '404' })
