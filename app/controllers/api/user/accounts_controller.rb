class Api::User::AccountsController < Api::UserController

  def update
    current_user.update(user_params)
    respond_with(current_user)
  end

  def update_password
    @user = User.find(current_user.id)

    if @user.update(user_params_with_password)
      # Sign in the user by passing validation in case their password changed
      sign_in(@user, bypass: true)
    end

    respond_with(@user)
  end

  private

  def user_params
    params.require(:user).permit(
      :id, :first_name, :last_name, :email, :church_name, :church_type_id,
      :is_auto_play, :radio_station_id, :background_pic, :profile_pic,
      :username, :facebook, :twitter, :linkedin, :background_color,
      :christian_for, :verse, :gender, :language,
      :year, :month, :day,
      address_attributes: [
        :id, :first_name, :last_name, :address_1, :address_2, :city,
        :region_id, :postcode, :country_id, :telephone
      ]
    )
  end

  def user_params_with_password
    params.require(:user).permit(:password, :password_confirmation)
  end
end
