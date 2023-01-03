class Api::Trends::ArticlesToTryController < Api::ApplicationController
  def index
    @articles_to_try = Article.order('random()').limit(4)
  end
end
