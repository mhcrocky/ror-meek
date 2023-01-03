angular.module("Meek").service 'HideOnClickAnywhereService', (
  $rootScope
  $state
) ->

  class HideOnClickAnywhere
    hideOnClickIfVisible: (targetSelector, activeClass) =>
      $('body').click (event) ->
        if $(targetSelector).hasClass(activeClass) && !$(event.target).is(targetSelector) && !$(event.target).closest(targetSelector).length
          $(targetSelector).removeClass(activeClass)

      return

  return new HideOnClickAnywhere()
