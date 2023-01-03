angular.module("Meek").service 'PlayerService', (
  $rootScope
  $interval
  Metadata

  AlertService
  ModalService
  Layout
  Play
) ->

  class Player
    _meekPlayer:               $('#meek-player')
    _playerCardImg:            $('.player-song-card img')
    _playerCardDescriptionRow: $('.player-song-card .song-card-user-description-row')
    _playerCardDescription:    $('.player-song-card .song-card-user-description')
    _playerCardTitle:          $('.player-song-card .song-card-title')


    constructor: ->
      @_player = $("#player").jPlayer
        solution: "html"
        supplied: "mp3"
        preload: "auto"
        volume: 0.8
        muted: false
        backgroundColor: "#000000"
        cssSelectorAncestor: "#meek-player"
        cssSelector:
          videoPlay: ".jp-video-play"
          play: ".new-jp-play"
          pause: ".new-jp-pause"
          stop: ".new-jp-stop"
          seekBar: ".new-jp-seek-bar"
          playBar: ".new-jp-play-bar"
          mute: ".new-jp-mute"
          unmute: ".new-jp-unmute"
          volumeBar: ".new-jp-volume-bar"
          volumeBarValue: ".new-jp-volume-bar-value"
          volumeMax: ".new-jp-volume-max"
          playbackRateBar: ".jp-playback-rate-bar"
          playbackRateBarValue: ".jp-playback-rate-bar-value"
          currentTime: ".new-jp-current-time"
          duration: ".new-jp-duration"
          title: ".jp-title"
          fullScreen: ".jp-full-screen"
          restoreScreen: ".jp-restore-screen"
          repeat: ".jp-repeat"
          repeatOff: ".jp-repeat-off"
          gui: ".jp-gui"
          noSolution: ".jp-no-solution"

        errorAlerts: false
        warningAlerts: false

        error: (e) =>
          if Layout.isMobile() && Layout.isFacebookApp()
            window.location.href = e.jPlayer.status.src
          else
            AlertService.display('The episode is not available at the moment.', 'warning')

          return

        pause: () =>
          $rootScope.$apply()

        play: () =>
          $rootScope.$apply()

      return

    startPodcast: (podcast, episode, stopped_at) =>
      if !podcast.private || $rootScope.auth.isAuthenticated()
        if @isCurrentTrack(episode) && @isAudioPlaying()
          @pause()
          return

        if @isCurrentTrack(episode) && !@isAudioPlaying()
          @play()
          return

        @_currentPodcast = podcast
        @_currentEpisode = episode
        @_currentRadioStation = undefined

        @setStream(@_currentEpisode.name, @_currentEpisode.stream_url)
        @showPodcastPlayer()
        @showPodcastInfo()
        @play(stopped_at)
      else
        ModalService.signInDialog()
        return          

      return


    showPodcastInfo:  =>
      $rootScope.playerInfo.setInfo(
        type:           'podcast'
        image:          @_currentPodcast.image
        title:          @_currentPodcast.name
        favoriteId:     @_currentEpisode.id
        favoriteType:   'Episode'

        episodeId:      @_currentEpisode.id
        podcastId:      @_currentPodcast.id
        categoryId:     @_currentPodcast.category_id

        currentPath:    @_currentEpisode.path
      )

      @_playerCardImg.attr('src', @_currentPodcast.image)
      @_playerCardTitle.html(@_currentPodcast.name)
      @_playerCardDescription.html(@_currentEpisode.name)

      @_playerCardDescriptionRow.show()

      return


    setStream: (title, streamUrl) =>

      if streamUrl
        @_player.jPlayer('setMedia', { mp3: streamUrl })
      else
        @_player.jPlayer('clearMedia')

      return


    play: (stopped_at) =>
      if stopped_at?
        @_player.jPlayer('play', stopped_at)
      else
        @_player.jPlayer('play')

      @showPlayer()
      @startPlayTracking()

    pause: =>
      @_player.jPlayer('pause') if @isAudioPlaying()
      return true

    showPlayer: =>
      $('body').addClass('player-enable')
      @_meekPlayer.show()

    showPodcastPlayer: =>
      @_meekPlayer.addClass('podcastIsPlaying')
      @_meekPlayer.removeClass('radioStationIsPlaying')

    isPlaying: =>
      return @_currentPodcast || @_currentRadioStation


    startPlayTracking: =>
      $interval.cancel( @_playTrackingTimeout )
      @playTrack = new Play()

      if @_currentEpisode?
        @playTrack.media_type = 'Episode'
        @playTrack.media_id = @_currentEpisode.id
      else
        @playTrack.media_type = 'RadioStation'
        @playTrack.media_id = @_currentRadioStation.id

      @playTrack.$save( =>
        $interval.cancel( @_playTrackingTimeout )
        @_playTrackingTimeout = $interval( @playTracking, 3000 )
      )

      return

    playTracking: =>
      id = @playTrack.id

      if id?
        user_id = $rootScope.auth.currentUser.id if $rootScope.auth.isAuthenticated()
        stopped_at = @_player.data("jPlayer").status.currentTime if @playTrack.media_type == 'Episode'

        Play.update({ id: id, user_id: user_id, stopped_at: stopped_at }) if @isAudioPlaying()

      return

    destroyPlayer: =>
      # cancel the all pooling requests.
      $interval.cancel( @_radioMetadataTimeout )
      $interval.cancel( @_playTrackingTimeout )

      @_currentPodcast = undefined
      @_currentEpisode = undefined
      @_currentRadioStation = undefined

      $('body').removeClass('player-enable')
      @_meekPlayer.hide()

      @_player.jPlayer('stop')

    _mobileUnAuthorized: =>
      if !$rootScope.auth.isAuthenticated() && Layout.isMobile()
        ModalService.signInDialog()
        return true

      return false

    isCurrentTrack: (audio) =>
      return @_currentEpisode && @_currentEpisode.id == audio.id

    isAudioPlaying: =>
      return !@_player.data().jPlayer.status.paused

  return new Player()
