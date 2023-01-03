angular.module("Meek").service 'ModalService', (
  $state

  ngDialog
  Layout
) ->

  class Modal

    signInDialog: =>
      if Layout.isMobile()
        $state.go('welcome.index')
      else
        @closeAll()

        ngDialog.open(
          template: 'signInDialog'
          showClose: false
          trapFocus: false
        )

      return false

    signUpDialog: =>
      @closeAll()

      ngDialog.open(
        template: 'signUpDialog'
        showClose: false
        trapFocus: false
      )

      return false


    forgotYourPassword: =>
      @closeAll()

      ngDialog.open(
        template: 'forgotYourPassword'
        showClose: false
        trapFocus: false
      )

      return false


    resendConfirmation: =>
      @closeAll()

      ngDialog.open(
        template: 'resendConfirmation'
        showClose: false
        trapFocus: false
      )

      return false


    inviteFriend: =>
      ngDialog.open(
        template: 'inviteFriend'
        showClose: false
        trapFocus: false
      )

      return false


    shareViaEmail: (media_name, media_path) =>
      ngDialog.open(
        template: 'shareViaEmail'
        showClose: false
        trapFocus: false
        controller: [
          '$scope'
          ($scope) ->
            $scope.media_name = media_name
            $scope.media_path = media_path

            return
        ]
      )

      return false


    newPassword: (token) =>
      ngDialog.open(
        template: 'newPassword'
        showClose: false
        trapFocus: false
        controller: [
          '$scope'
          ($scope) ->
            $scope.token = token

            return
        ]
      )

      return false


    editContactInfo: (user_country_id) =>
      @closeAll()

      ngDialog.open(
        template: 'editContactInfo'
        className: 'profile-modal'
        showClose: false
        trapFocus: false
        controller: [
          '$scope', 'Country'
          ($scope, Country) ->

            $scope.updateCountry = (country_id) ->
              $scope.country = Country.get({ id: country_id })
              return

            $scope.countries = Country.query()
            $scope.updateCountry(user_country_id)

            return
        ]
      )

      return false


    editDetailsInfo: =>
      @closeAll()

      ngDialog.open(
        template: 'editDetailsInfo'
        className: 'profile-modal'
        showClose: false
        trapFocus: false
        controller: [
          '$scope', 'ChurchType'
          ($scope, ChurchType) ->
            $scope.churchTypes = ChurchType.query()
            $scope.genders = [ 'Male', 'Female' ]

            return
        ]
      )

      return false


    editAccountInfo: =>
      @closeAll()

      ngDialog.open(
        template: 'editAccountInfo'
        className: 'profile-modal'
        showClose: false
        trapFocus: false
      )

      return false


    editSettingsInfo: =>
      @closeAll()

      ngDialog.open(
        template: 'editSettingsInfo'
        className: 'profile-modal'
        showClose: false
        trapFocus: false
      )

      return false



    closeAll: =>
      ngDialog.closeAll()

      return false

  return new Modal()
