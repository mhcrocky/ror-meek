angular.module("Meek").controller "InviteesController", (
  $http
  $state
  $rootScope
  $stateParams
  ApplicationService
  Auth
) ->

  Auth.currentUser().then ((user) ->
    $state.go('profile', {id: user.slug})
  ), (error) ->

    result = $http(
      url: '/api/invitation/edit.json'
      method: 'GET'
      params: { invitation_token: $stateParams.token }
    )

    result.success ->
      $('#acceptInvitation').find('input[name*="[invitation_token]"]').val( $stateParams.token )

    result.error ->
      $rootScope.alert.display('Token is not valid or User already created', 'danger')
