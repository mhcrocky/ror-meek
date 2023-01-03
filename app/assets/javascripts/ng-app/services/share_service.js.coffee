angular.module("Meek").service 'ShareService', (
  $location
  ModalService
) ->

  class Share

    rootUrls: ->
      # Remvoe to UTILS
      # window.location.origin
      $location.$$protocol + '://' + $location.$$host


    shareLink: ( type, opts ) =>
      url     = @rootUrls() + opts.linkPath
      image   = @rootUrls() + opts.imagePath
      text    = opts.title

      if type == 'google'
        @_shareGoogle(url)

      if type == 'facebook'
        @_shareFacebook(url)

      if type == 'twitter'
        @_shareTwitter(url, text)

      if type == 'pinterest'
        @_sharePinterest(url, text, image)

      if type == 'email'
        @_shareEmail(url, text)

      return

    _shareEmail: (url, text) =>
      ModalService.shareViaEmail( text, url )

    _shareGoogle: (url) =>
      @_open("https://plus.google.com/share?url=#{ url }")

    _shareFacebook: (url) =>
      @_open("https://www.facebook.com/sharer/sharer.php?u=#{ url }")

    _shareTwitter: (url, text) =>
      @_open("https://twitter.com/share?url=#{ url }&text=#{ text }")

    _sharePinterest: (url, text, image) =>
      @_open("http://pinterest.com/pin/create/button/?url=#{ url }&description=#{ text }&media=#{ image }")


    _open: (url) ->
      window.open(url, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600')
      return

  return new Share()
