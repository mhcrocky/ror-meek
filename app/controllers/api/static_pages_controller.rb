class Api::StaticPagesController < Api::ApplicationController

  def show
    @static_page = StaticPage.friendly.find(params[:id])
  end

end
