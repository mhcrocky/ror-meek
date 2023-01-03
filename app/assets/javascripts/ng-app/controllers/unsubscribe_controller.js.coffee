angular.module('Meek').controller 'UnsubscribeController', (
  $state
  $stateParams

  Unsubscribe

  ApplicationService
  AlertService
) ->

  Unsubscribe.update({ id: $stateParams.email }, (response) ->
    status = if response.status == 200 then 'success' else 'warning'

    AlertService.display(response.message, status)
    $state.go('home')
  )
