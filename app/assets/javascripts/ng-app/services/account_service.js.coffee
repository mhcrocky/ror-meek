angular.module("Meek").service 'AccountService', (
  AuthenticationService
  FormService
  AlertService
  ModalService
) ->

  class Account

    accountUpdate: (event) ->
      event.preventDefault()
      $form = $(event.target)

      FormService.clearErrors($form)

      $result = FormService.submit($form)

      $result.success (data, status, headers, config) ->
        ModalService.closeAll()
        AuthenticationService.reloadCurrentUser()
        AlertService.display('Your account information has been updated.', 'success')

      $result.error (data, status, headers, config) ->
        FormService.displayErrors($form, data)

  return new Account()
