angular.module("Meek").service 'FavoriteService', (
  $http
  AlertService
  ModalService
  AuthenticationService

  Favorite
) ->

  class FavoriteService

    addToFavorite: (id, type) =>

      if AuthenticationService.isAuthenticated()
        data = {
          favoritable_type: type
          favoritable_id: id
        }

        @_create(data)

      else
        ModalService.signInDialog()

      return


    _create: (data) ->
      Favorite.save { favorite: data }, ((responce) ->
        AlertService.display('Successfully added to your favorites.', 'success')
        return
      ), ->
        AlertService.display('Already in your favorites.', 'warning')
        return

      return

    _delete: (data) ->
      Favorite.delete { id: data.favoritable_id, favorite_type: data.favoritable_type }, ((responce) ->
        AlertService.display('Successfully removed from your favorites.', 'success')
        return
      ), ->
        AlertService.display('Not in your favorites.', 'warning')
        return

      return



    setDefaultRadio: (radioStationId) ->
      if AuthenticationService.isAuthenticated()

        result = $http(
          url: '/api/user/account.json'
          method: 'PATCH'
          data: { user: { radio_station_id: radioStationId } }
        )

        result.success ->
          AlertService.display('Your defualt radio station has been set', 'success')
          return

        result.error ->
          AlertService.display('There was a problem setting your default radio station', 'warning')
          return

      else
        ModalService.signInDialog()

      return


  return new FavoriteService()
