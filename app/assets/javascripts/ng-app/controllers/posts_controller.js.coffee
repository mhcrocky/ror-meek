angular.module("Meek").controller "PostsController", (
  $rootScope,
  $scope,
  $stateParams,
  $sce

  Category
  Post
  Article

  ApplicationService
) ->

  $scope.category = Category.get({ id: $stateParams.categoryId })
  $scope.article = Article.get({ id: $stateParams.articleId })
  $scope.post = Post.get({ postId: $stateParams.postId, articleId: $stateParams.articleId }, (post) ->
    metaInformation = {
      title:          post.meta_title
      description:    post.meta_description
      imagePath:      post.image
      googlebotImage: post.googlebot
      videoUrl:       post.stream_url if post.video
    }
    $rootScope.head.setAllMetaInformation(metaInformation)

    $rootScope.head.setMetaTag({ name: 'robots', content: 'noindex' }) if post.noindex

    $scope.htmlSafeTranscription = $sce.trustAsHtml(post.transcription)
    $scope.schema_content = $sce.trustAsHtml(post.schema)
  )
