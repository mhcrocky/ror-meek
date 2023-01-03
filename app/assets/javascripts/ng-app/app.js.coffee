meek = angular.module("Meek", [
  "templates"
  "angulartics"
  "angulartics.google.tagmanager"
  "ui.router"
  "ngResource"
  "Devise"
  "ngDialog"
  "toaster"
  "ngStorage"
  "ngCookies"
])

meek.config ($locationProvider
  $httpProvider
  $stateProvider
  $urlRouterProvider
  AuthProvider) ->
  $urlRouterProvider.otherwise('/')

  $stateProvider
    .state('404',
    url: '/404'
    views:
      '':
        template: ""
        controller: "ErrorsController"
  )

    .state('home',
    url: '/?reset_password_token'
    views:
      '':
        template: ""
        controller: "HomeController"
  )

    .state('profile',
    url: '/me/:id'
    views:
      '':
        templateUrl: "profile.html"
        controller: "ProfileController"
  )

# Unsubscribe
    .state('unsubscribe',
    url: '/unsubscribe?email'
    views:
      '':
        template: ''
        controller: 'UnsubscribeController'
  )
    .state('landingPages',
    url: '/pages/:id'
    views:
      '':
        controller: "StaticPagesController"
  )

    .state('setupAccount',
    url: '/setup'
    views:
      '':
        controller: "StaticPagesController"
  )

    .state('setupAccountComplete',
    url: '/setup/thank-you'
    views:
      '':
        controller: "StaticPagesController"
  )

# Radio Stations
    .state('radioStations',
    url: '/radio/:id'
    views:
      '':
        controller: "CategoriesController"
  )
    .state('radioStation'
    url: '/radio/:categoryId/:id'
    views:
      '':
        templateUrl: "radio_station.html"
        controller: "RadioStationsController"
  )

# Static Pages
    .state('about',
    url: '/about'
    views:
      '':
        controller: "StaticPagesController"
  )
    .state('terms',
    url: '/terms'
    views:
      '':
        controller: "StaticPagesController"
  )
    .state('privacy',
    url: '/privacy'
    views:
      '':
        controller: "StaticPagesController"
  )
    .state('contactus',
    url: '/contactus'
    views:
      '':
        controller: "StaticPagesController"
  )
    .state('cookies',
    url: '/cookies'
    views:
      '':
        controller: "StaticPagesController"
  )

# Search
    .state('search',
    url: '/search?search'
    views:
      '':
        controller: "SearchController"
  )

    .state('welcome',
    abstract: true,
    views:
      '':
        templateUrl: "welcome.html"
        controller: "WelcomeController"
  )
    .state('welcome.index',
    url: '/welcome/index'
    templateUrl: 'welcome/index.html'
  )

# Favorites
    .state('favoritePodcasts',
    url: '/favorite/podcasts'
    views:
      '':
        templateUrl: "favorite/podcasts.html"
        controller: "FavoritePodcastsController"
  )
    .state('favoriteEpisodes',
    url: '/favorite/episodes'
    views:
      '':
        templateUrl: "favorite/episodes.html"
        controller: "FavoriteEpisodesController"
  )
    .state('favoriteRadioStations',
    url: '/favorite/radio'
    views:
      '':
        templateUrl: "favorite/radio_stations.html"
        controller: "FavoriteRadioStationsController"
  )
    .state('favoriteArticles',
    url: '/favorite/articles'
    views:
      '':
        templateUrl: "favorite/articles.html"
        controller: "FavoriteArticlesController"
  )
    .state('favoriteAll',
    url: '/favorite'
    views:
      '':
        templateUrl: "favorite/all.html"
        controller: "FavoriteAllController"
  )

# Invitation
    .state('invite',
    url: '/invitees/:token'
    views:
      '':
        templateUrl: 'invite/invitee.html'
        controller: 'InviteesController'
  )

# Podcasts
    .state('podcasts',
    url: '/:id',
    views:
      '':
        controller: "CategoriesController"
  )
    .state('podcast',
    url: '/:categoryId/:id?page'
    views:
      '':
        templateUrl: "podcast.html"
        controller: "PodcastsController"
  )

# Episodes
    .state('episode',
    url: '/:categoryId/:podcastId/:id'
    views:
      '':
        templateUrl: "episode.html"
        controller: "EpisodesController"
  )

# Articles
    .state('articles',
    url: '/article/:id',
    views:
      '':
        controller: "CategoriesController"
  )
    .state('article',
    url: '/article/:categoryId/:id?page'
    views:
      '':
        templateUrl: "article.html"
        controller: "ArticlesController"
  )

# Posts
    .state('post',
    url: '/article/:categoryId/:articleId/:postId'
    views:
      '':
        templateUrl: "post.html"
        controller: "PostsController"
  )

  # HTML5

  $locationProvider.html5Mode(true).hashPrefix('!')


  # Devise configuration

  AuthProvider.loginPath('/api/users/sign_in.json');
  AuthProvider.registerPath('/api/users.json');
  AuthProvider.logoutPath('/api/users/sign_out.json');

  $httpProvider.interceptors.push('httpInterceptor');

  return

# React.js integration
meek.run(['$rootScope', '$state', '$stateParams', '$transitions', 'toaster'
  ($rootScope, $state, $stateParams, $transitions, toaster) ->
    $rootScope.$state = $state
    $rootScope.$stateParams = $stateParams

    window._bridge = {} if !window._bridge

    window._bridge.rootScope = $rootScope
    window._bridge.go = $rootScope.$state.go
    window._bridge.toaster = toaster

    $transitions.onSuccess {}, (transition) ->
      params = transition.params()
      window._bridge.redux.dispatch
        type: 'ROUTER__UPDATE_PAGE',
        page: transition.to().name
        params: transition.params()

])