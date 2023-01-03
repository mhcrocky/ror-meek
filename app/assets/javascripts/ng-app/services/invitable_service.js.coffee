angular.module("Meek").service 'InvitableService', (
  $location
  AlertService
  FormService
  ModalService
) ->

  class Inviter

    submit: (event) =>
      event.preventDefault()
      $form = $(event.target)

      FormService.clearErrors($form)
      result = FormService.submit($form)

      result.success =>
        ModalService.closeAll()
        AlertService.display('Your invite has been sent. Thank You.', 'success')

      result.error (data) =>
        FormService.displayErrors($form, data)


    accept: (event) =>
      event.preventDefault()
      $form = $(event.target)

      FormService.clearErrors($form)
      result = FormService.submit($form)

      result.success =>
        window.location = '/'

      result.error (data) =>
        FormService.displayErrors($form, data)

  return new Inviter()
