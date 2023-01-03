class Api::PlaysController < Api::ApplicationController

  def create
    @play = if current_user
      current_user.plays.find_or_create_by(create_play_params)
    else
      Play.create(create_play_params)
    end

    respond_with :api, @play
  end

  def update
    @play = Play.find_by(id: params[:play][:id])

    if @play
      @play.update_attributes( update_play_params.merge( updated_at: Time.now ))
    end

    render nothing: true, status: 200
  end


  private
  def create_play_params
    params.require(:play).permit( :media_id, :media_type )
  end
  def update_play_params
    params.require(:play).permit( :user_id, :stopped_at )
  end
end
