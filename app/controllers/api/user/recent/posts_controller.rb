class Api::User::Recent::PostsController < Api::UserController
  def index
    @recent_posts = Post.all
  end
end
