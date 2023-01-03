angular.module("Meek").service 'AuthenticationService', (
  $stateParams
  $location
  $state
  $cookies

  RadioStation

  Auth
  AlertService
  FormService
  ModalService
  PlayerService

  Layout
) ->

  class Authentication
    _newPasswordForm: $('#user-new-password-form')

    constructor: ->
      @setCurrentUser()

      if $stateParams.reset_password_token
        ModalService.newPassword($stateParams.reset_password_token)

      this.Auth = Auth

      return this


    submitUserRegistration: (event) =>
      event.preventDefault()
      _registrationForm = $(event.currentTarget)

      FormService.clearErrors(_registrationForm)

      credentials = {
        email: _registrationForm.find('input[name=email]').val(),
        password: _registrationForm.find('input[name=password]').val(),
        password_confirmation: _registrationForm.find('input[name=password_confirmation]').val()
        first_name: _registrationForm.find('input[name=first_name]').val()
        last_name: _registrationForm.find('input[name=last_name]').val()
      }

      Auth.register(credentials).then ((user) =>
        # Auth#register automaticaly set _currentUser on save.
        Auth._currentUser = undefined

        ModalService.closeAll()
        AlertService.display('You need confirm your email', 'warning')
        return
      ), (errors) =>
        FormService.displayErrors(_registrationForm, errors.data)
        return

      return


    submitLogin: (event) =>
      event.preventDefault()
      _signInForm = $(event.currentTarget)

      FormService.clearErrors(_signInForm)

      credentials = {
        email: _signInForm.find('input[name=email]').val(),
        password: _signInForm.find('input[name=password]').val(),
      }

      Auth.login(credentials).then ((user) =>
        AlertService.display('Welcome back!', 'success')
        @setCurrentUser()

        ModalService.closeAll()
        @redirectAfterLogin( user.slug ) if Layout.isMobile()
        return
      ), (errors) =>
        FormService.displayErrors(_signInForm, errors.data)
        return

      return


    isAuthenticated: ->
      Auth.isAuthenticated()


    setCurrentUser: =>
      Auth.currentUser().then ((user) =>
        @currentUser = user
        user.isAuthenticated = @isAuthenticated()
        @startDefaultRadio()
        window._bridge.redux.dispatch
          type: 'USER__UPDATE'
          value: user

        return
      ), (error) =>
        @currentUser = null
        window._bridge.redux.dispatch
          type: 'USER__RESET'
        return

      return


    logout: =>
      Auth.logout().then ( =>
        @currentUser = undefined
        AlertService.display('You have been logged out', 'success')
        window._bridge.redux.dispatch
          type: 'USER__RESET'

        if PlayerService.isPlaying() && Layout.isMobile()
          PlayerService.destroyPlayer()

        $state.go('home')
      ), (error) ->
        AlertService.display('There was a problem logging out. Please try again.', 'warning')

      return


    reloadCurrentUser: =>
      Auth.reset()
      @setCurrentUser()


    submitPasswordReset: (event) =>
      event.preventDefault()
      _passwordResetForm = $(event.currentTarget)

      FormService.clearErrors(_passwordResetForm)

      result = FormService.submit(_passwordResetForm)
      result.success (data) =>
        ModalService.closeAll()
        AlertService.display('An email with password reset instructions has been sent to you.', 'success')
        return

      result.error (data) =>
        FormService.displayErrors(_passwordResetForm, data)
        return

      return


    submitEmailReconfirm: (event) =>
      event.preventDefault()
      _resendConfirmationForm = $(event.currentTarget)

      FormService.clearErrors(_resendConfirmationForm)

      result = FormService.submit(_resendConfirmationForm)
      result.success (data) =>
        ModalService.closeAll()
        AlertService.display('An email with confirmation link has been sent to you.', 'success')
        return

      result.error (data) =>
        FormService.displayErrors(_resendConfirmationForm, data)
        return

      return

    submitNewPassword: (event) =>
      event.preventDefault()
      _newPasswordForm = $(event.currentTarget)

      FormService.clearErrors(_newPasswordForm)
      result = FormService.submit(_newPasswordForm)

      result.success (data) =>
        @reloadCurrentUser()

        ModalService.closeAll()
        AlertService.display('Your password has been reset.', 'success')

        # $state.go('home')
        $location.url('/')

        return

      result.error (data) =>
        FormService.displayErrors(_newPasswordForm, data)
        return

      return

    changePassword: (event) =>
      event.preventDefault()

      $form = $(event.target)

      FormService.clearErrors($form)

      $result = FormService.submit($form)

      $result.success (data, status, headers, config) =>
        @reloadCurrentUser()

        FormService.clearFields($form)

        ModalService.closeAll()
        AlertService.display('Your password was changed.', 'success')

      $result.error (data, status, headers, config) =>
        FormService.displayErrors($form, data)

    startDefaultRadio: =>
      return if !@currentUser.radio_station_id || !@currentUser.is_auto_play || PlayerService.isPlaying()

      RadioStation.get({ id: @currentUser.radio_station_id }, (stationStation) ->
        PlayerService.startRadio(stationStation)
      )

      return

    redirectAfterLogin: (slug) =>
      url = $cookies.get('previouseState') || '/'
      $location.url( url )


  return new Authentication()
