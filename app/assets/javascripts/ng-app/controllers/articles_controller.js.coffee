angular.module("Meek").controller "ArticlesController", (
  $sce
  $http
  $rootScope
  $scope
  $stateParams
  $timeout
  Category
  Article
  Post
  ApplicationService
) ->

  $scope.category = Category.get({ id: $stateParams.categoryId })

  $scope.article = Article.get({ id: $stateParams.id }, (article) ->
    $rootScope.head.setMetaTag({ name: 'robots', content: 'noindex' }) if article.noindex
    $rootScope.head.setAllMetaInformation({ 
      title: article.meta_title,
      description: article.meta_description,
      imagePath: article.image,
      googlebotImage: article.googlebot
    })

    $scope.htmlSafeDescription = $sce.trustAsHtml(article.description)
    $scope.schema_content = $sce.trustAsHtml(article.schema)
  )

  $scope.searchQuery = { text: '' }
  $scope.pages = []
  $scope.posts = []
  $scope.postsCount = null
  $scope.postsNextPage = null
  $scope.postActive = null

  $scope.loadMorePosts = (page, searchQuery) ->
    return if !page

    if page == 1
      $scope.pages = []
      $scope.posts = []

    Post.get({ articleId: $stateParams.id, page: page, search_query: searchQuery }, (response) ->
      $scope.pages[page] = response.data
      $scope.posts = $scope.pages.flatten()
      $scope.postsCount = response.pagination.total
      $scope.postsNextPage = response.pagination.next
    )

  $scope.loadMorePosts(1)

  $scope.toggleActive = (post, event) ->
    event.stopPropagation()
    $timeout ->
      $scope.postActive = post.id

  $scope.toggleActivePost = (post) ->
    window.open(post.stream_url)

  $scope.isActive = (post) ->
    post.id == $scope.postActive
