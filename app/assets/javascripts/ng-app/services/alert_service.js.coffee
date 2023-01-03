angular.module("Meek").service 'AlertService', (
  toaster
) ->

  class Alert
    display: (message, type) ->
      toaster.pop(type, null, message)

  return new Alert()
