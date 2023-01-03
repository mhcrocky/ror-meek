angular.module('Meek').directive 'meekVideoPlayerWrapper', (
) ->

  {
    restrict: 'E'
    template: '<div id="meek-video-container"></div>'
    replace: true

    link: (scope, elem, attrs, model) ->
      elem.ready ->
        scope.videoPlayer.init(scope.episode)

        return
  }
