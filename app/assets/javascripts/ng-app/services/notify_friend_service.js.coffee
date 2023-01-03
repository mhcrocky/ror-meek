angular.module('Meek').service 'NotifyFriendService', (
  ModalService
  AlertService
  FormService
) ->

  class NotifyFriend

    submit: (event) ->
      event.preventDefault()
      $form = $(event.target)

      FormService.clearErrors($form)
      result = FormService.submit($form)

      result.success =>
        ModalService.closeAll()
        AlertService.display('Notifyed.', 'success')

      result.error (data) =>
        FormService.displayErrors($form, data)

      return false

  return new NotifyFriend()
