angular.module("Meek").controller "FavoriteArticlesController", (
  $rootScope
  $scope

  FavoriteArticles

  ApplicationService
) ->

  $rootScope.head.setTitle('Favorite Articles')

  $scope.favorite_type = 'articles'

  $scope.articles = FavoriteArticles.query()
