angular.module('Meek').directive 'scrollBottomSensor', ($window) ->
  {
    restrict: 'E'
    template: "<div class='scroll-bottom-sensor'></div>"
    replace:  true

    link: (scope, elem, attrs) ->
      $window = angular.element $window
      {onReachBottom, scrollThreshold = 100, requestDelay = 500} = attrs

      scrollListener = $.throttle(
        ->
          {innerHeight, pageYOffset} = window
          position = (innerHeight + pageYOffset)
          height = Math.max(
            document.body.scrollHeight,
            document.documentElement.scrollHeight,
            document.body.offsetHeight,
            document.documentElement.offsetHeight,
            document.body.clientHeight,
            document.documentElement.clientHeight
          )


          if (position >= height - scrollThreshold)
            scope.$apply onReachBottom
            
      , requestDelay)

      $window.on 'scroll', scrollListener
      elem.on '$destroy', -> $window.off 'scroll'

  }





