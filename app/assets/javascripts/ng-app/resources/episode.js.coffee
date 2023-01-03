angular.module("Meek").factory "Episode", ($resource) ->

  $resource "/api/podcasts/:podcastId/episodes/:id", { format: 'json', page: 1 }, {
    get: { cache: true }
  }
