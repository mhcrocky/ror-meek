angular.module('Meek').service 'VideoPlayerService', (
  $rootScope
  Layout

  ModalService
  ShareService
) ->

  class VideosPlayer
    init: (episode) =>
      $rootScope.player.pause()
      @_removeOldVideoPlayer()
      @_createVideoTag()
      @_initVideoJS(episode)
      @_setShareButtons(episode)
      window.pl=@_videoPlayer
      return

    pause: =>
      @_videoPlayer.pause()
      return

    play: =>
      console.log('.play()', @_videoPlayer.source);
      @_videoPlayer.play()
      return

    openVideoDialog: (episode) =>
      if !episode.private || $rootScope.auth.isAuthenticated()
        @init( episode )
        $('#videoDialog').show()
      else
        ModalService.signInDialog()
        return
      return

    closeVideoDialog: ->
      @_videoPlayer.pause()
      $('#videoDialog').hide()
      return

    shareBy: (type) =>
      ShareService.shareLink(type, { imagePath: @_shareImage, title: @_shareTitle, linkPath: @_sharePath })
      return

    _removeOldVideoPlayer: =>
      if @_videoPlayer
        @_videoPlayer.destroy()
      return

    _createVideoTag: =>
      $('#meek-video-container').empty().append('<video class="video-js"></video>')
      return

    _initVideoJS: (ep) =>
      @_videoPlayer = new Plyr($('video')[0],
        playsinline: true,
        fullscreen: { enabled: true, fallback: true, iosNative: true }
      )
      @_videoPlayer.source =
        type: 'video',
        sources: [
          src: ep.stream_url
          provider: ep.stream_url_type.split('/')[1]
        ]
      # Safari on iOS has required a user gesture to play media in a <video> or <audio> element
      # https://webkit.org/blog/6784/new-video-policies-for-ios/
      @_videoPlayer.on('ready', => @play()) unless !!navigator.platform && /iPad|iPhone|iPod/.test(navigator.platform)
      return

    _setShareButtons: (ep) =>
      @_sharePath  = ep.path
      @_shareTitle = ep.name
      @_shareImage = ep.image
      return

  return new VideosPlayer

