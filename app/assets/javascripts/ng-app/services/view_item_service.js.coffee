angular.module('Meek').service 'ViewItemsService', (
  $localStorage
) ->

  class ViewItems

    constructor: ->
      @_currentView = $localStorage.itemView || 'list-view'
      return this

    setView: (classView) =>
      @_currentView = $localStorage.itemView = classView

      return @_currentView

    currentView: =>
      return @_currentView

  return new ViewItems()
