angular.module("Meek").service 'Layout', ->

  class Layout

    isMobile: ->
      $(window).width() < 768

    isFacebookApp: ->
      ua = navigator.userAgent || navigator.vendor || window.opera
      (ua.indexOf("FBAN") > -1) || (ua.indexOf("FBAV") > -1)

  return new Layout()
