angular.module("Meek").controller "WelcomeController", (
  $state
  $rootScope
  $scope

  ApplicationService

  Auth
  AuthenticationService
) ->

  Auth.currentUser().then ((user) ->
    $state.go('profile', {id: user.slug})
  )

  $rootScope.head.setTitle('Welcome To Meek')

  $scope.selectedTab = 'signin'
