angular.module("Meek").factory 'PaginationFactory', ($location) ->

  class Pagination

    constructor: (collection) ->
      @collection = collection

      return this

    range: =>
      range = new Array()

      if @collection.last - @collection.current < 2
        i = -4 + ( @collection.last - @collection.current )
      else
        i = -2

      while range.length < 5
        page = @collection.current + i
        break if page > @collection.last

        if page >= 1 && page <= @collection.last
          range.push(page)

        i++

      return range


    nLink: (page) =>
      "#{$location.path()}?page=#{page}"


    firstLink: =>
      @nLink(@collection.first)


    lastLink: =>
      @nLink(@collection.last)


    totalCount: =>
      @collection.total


  return Pagination
