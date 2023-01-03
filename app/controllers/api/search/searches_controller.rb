class Api::Search::SearchesController < ApplicationController
  respond_to :json

  def show
    media_type = params[:type]
    query = params[:search]

    if query.present?
      _results = SearchService.new(query).send(media_type)

      @paginated_results = Kaminari.paginate_array( _results.to_a ).page(params[:page]).per(4)

      render "search_#{media_type}"
    else
      render nothing: true
    end
  end
end
