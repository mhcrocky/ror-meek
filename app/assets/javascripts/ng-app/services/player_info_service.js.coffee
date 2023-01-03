angular.module("Meek").service 'PlayerInfoService', (
  $state
  FavoriteService
  ModalService
  HideOnClickAnywhereService
  ShareService
) ->

  class PlayerInfo

    _playerInfo:               $('.player-info')
    _playerInfoType:           $('.player-info-container .type')
    _playerInfoTitle:          $('.player-info-container .title')
    _playerInfoDescription:    $('.player-info-container .text')
    _playerInfoImage:          $('.player-info-container .player-info-image')

    _title: null
    _path: null

    _defaultRadioId: null
    _favoriteId: null
    _favoriteType: null

    _episodeId: null
    _podcastId: null
    _categoryId: null
    _radioStationId: null

    constructor: ->
      # EVENTS
      HideOnClickAnywhereService.hideOnClickIfVisible('.player-info', 'active')

      $('.player-info .player-button').click (event) ->
        $('.player-info').toggleClass('active')

    setInfo: (options) =>
      @_title          = options.title
      @_path           = options.currentPath
      @_image          = options.image


      @_favoriteId     = options.favoriteId
      @_favoriteType   = options.favoriteType
      @_defaultRadioId = options.defaultRadioId


      @_episodeId      = options.episodeId
      @_podcastId      = options.podcastId
      @_categoryId     = options.categoryId
      @_radioStationId = options.radioStationId


      @_playerInfoType.html( options.type )
      @_playerInfoTitle.html( @_title )
      @_playerInfoDescription.html( options.description )
      @_playerInfoImage.attr('src', options.image )


    addToFavorite: =>
      @_hidePlayerInfo()
      FavoriteService.addToFavorite( @_favoriteId, @_favoriteType )

    setAsDefault: =>
      @_hidePlayerInfo()
      FavoriteService.setDefaultRadio( @_defaultRadioId )



    goToEpisodePage: =>
      @_hidePlayerInfo()
      $state.go('episode', { categoryId: @_categoryId, podcastId: @_podcastId, id: @_episodeId })
      return

    goToPodcastPage: =>
      @_hidePlayerInfo()
      $state.go('podcast', { categoryId: @_categoryId, id: @_podcastId })
      return

    goToRadioStationPage: =>
      @_hidePlayerInfo()
      $state.go('radioStation', { categoryId: @_categoryId, id: @_radioStationId })
      return

    shareBy: (type) =>
      ShareService.shareLink(type, { imagePath: @_image, title: @_title, linkPath: @_path })
      return

    shareViaEmail: =>
      @_hidePlayerInfo()
      ModalService.shareViaEmail( @_title, @_path )
      return


    _hidePlayerInfo: =>
      @_playerInfo.removeClass('active')
      return


  return new PlayerInfo()
