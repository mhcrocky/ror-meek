angular.module("Meek").service 'SideNavigationService', (
  $rootScope,
  $state,

  Layout
  HideOnClickAnywhereService
) ->

  class SideNavigation
    constructor: ->
      $('body').on 'click', '#sidenav-button', @toggleSideBar
      $('body').on 'click', 'article, footer, #side-navigation-wrapper li a', @closeSideNav

      return this

    toggleSideBar: =>
      $sideNavgiation = $('#side-navigation-wrapper')

      if $sideNavgiation.hasClass('open')
        @closeSideNav()
      else
        @openSideNav()
      return

    openSideNav: ->
      $sideNavgiation = $('#side-navigation-wrapper')
      $sideNavgiation.addClass('open')
      return

    closeSideNav: =>
      @hideAllSections()

      $sideNavgiation = $('#side-navigation-wrapper')
      $sideNavgiation.removeClass('open')
      return

    toggleSection: (event) =>
      $section = $(event.target).parents('.section')

      @_toggleSection($section.siblings('.section.active'))
      @_toggleSection($section)
      return

    _toggleSection: ($toggleSection) ->
      $toggleSection.toggleClass('active')

      if Layout.isMobile()
        $toggleSection.find('ul').slideToggle()
      else
        $toggleSection.find('ul').toggle()
      return

    hideAllSections: ->
      $sections      = $('.section')
      $panelSections = $sections.find('.new-panel-section')

      $sections.removeClass('active')

      if Layout.isMobile()
        $panelSections.slideUp()
      else
        $panelSections.hide()
      return

  return new SideNavigation()
