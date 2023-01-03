angular.module("Meek").service 'SearcherService', (
  $state
) ->

  class Searcher
    constructor: () ->
      $('body').click (event) ->
        if $('.header-search-link').hasClass('open') && !$(event.target).parents('.header-search').length && !$(event.target).hasClass('header-search')
          $('.header-search-link').removeClass('open')

      $('.header-search-link').on 'click', (event) ->
        $(event.currentTarget).toggleClass('open')
        false


    submit: (event) ->
      event.preventDefault()

      searchBox = $(event.target).find('input')
      searchValue = searchBox.val()
      searchBox.val('')
      searchBox.blur()

      $('.header-search-link').removeClass('open')

      $state.go('search', search: searchValue)


  return new Searcher()
