angular.module("Meek").controller "CategoriesController", (
  $location,
  $rootScope,
  $scope,
  $stateParams,
  Category,
  ApplicationService
) ->

  $scope.category = Category.get id: $stateParams.id, (category) ->
    $rootScope.head.setAllMetaInformation({ title: category.meta_title, description: category.meta_description })
