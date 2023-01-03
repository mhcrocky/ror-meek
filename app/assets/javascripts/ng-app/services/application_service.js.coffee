angular.module("Meek").service 'ApplicationService', (
  $location
  $rootScope
  $state
  $cookies
  $localStorage
  $sce

  Background
  Category

  AlertService
  AuthenticationService
  FavoriteService
  FeedbackService
  FormService
  HeadService
  Layout
  ModalService
  PlayerService
  ShareService
  SideNavigationService
  SearcherService
  InvitableService
  PlayerInfoService
  DurationService
  AccountService
  NotifyFriendService
  ViewItemsService
  VideoPlayerService
) ->

  $rootScope.alert = AlertService
  $rootScope.auth = AuthenticationService
  $rootScope.categories = Category.query()
  $rootScope.favorite = FavoriteService
  $rootScope.form = FormService
  $rootScope.head = HeadService
  $rootScope.player = PlayerService
  $rootScope.videoPlayer = VideoPlayerService
  $rootScope.share = ShareService
  $rootScope.sideNav = SideNavigationService
  $rootScope.$state = $state
  $rootScope.search = SearcherService
  $rootScope.invitable = InvitableService
  $rootScope.modal = ModalService
  $rootScope.playerInfo = PlayerInfoService
  $rootScope.duration = DurationService
  $rootScope.editAccount = AccountService
  $rootScope.notifyFriend = NotifyFriendService
  $rootScope.listItemView = ViewItemsService

  $rootScope.meekCookies = $cookies

  $rootScope.setCookiesAllowed = () ->
    $localStorage.meek_cookies_allowed = true

  $rootScope.isCookiesAllowed = () ->
    allowed = $localStorage.meek_cookies_allowed
    return Boolean(allowed)


  class Application
    constructor: ->
      # TODO: duplication.
      @setCurrentLayout()
      @showAlertFromCookies()

      $rootScope.$on '$stateChangeSuccess', (event, to, toParams, from, fromParams) =>
        @rememberLocation( to.name, toParams )
        @setCurrentLayout()
        @showAlertFromCookies()

    showAlertFromCookies: =>
      message = $rootScope.meekCookies.get('error_message_meek')

      if message
        $rootScope.meekCookies.remove('error_message_meek')
        message = message.replace(/\+/g, ' ')
        AlertService.display( message , 'warning')

    setCurrentLayout: ->
      $rootScope.currentLayout = 'default'

      if $rootScope.$state.includes('welcome.*')
        $rootScope.currentLayout = 'welcome'

    rememberLocation: (toName, toParams) =>
      return if $rootScope.$state.includes('welcome.*')

      currentPath = $rootScope.$state.href(toName, toParams)
      $rootScope.meekCookies.put('previouseState', currentPath)

  return new Application()
