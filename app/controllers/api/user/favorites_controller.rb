class Api::User::FavoritesController < Api::UserController
  def show
    @favorite = current_user.favorites.find params[:id]
  end

  def create
    @favorite = current_user.favorites.new(favorite_params)
    @favorite.save

    respond_with :api, :user, @favorite
  end

  def destroy
    @favorite = current_user.favorites.find_by(favoritable_id: params[:id], favoritable_type: params[:favorite_type])
    @favorite.delete

    respond_with :api, :user, @favorite
  end

  private

  def favorite_params
    params.require(:favorite).permit(:favoritable_type, :favoritable_id)
  end

end
