angular.module("Meek").factory "Post", ($resource) ->
  $resource "/api/articles/:articleId/posts/:postId", { format: 'json', page: 1 }, {
    get: { cache: true }
  }
