class FacebookPageApi

  # NOTE:
  # https://github.com/arsduo/koala/wiki/Acting-as-a-Page
  # Token generator: https://developers.facebook.com/tools/explorer
  # Token checker: https://developers.facebook.com/tools/debug/accesstoken

  def initialize
    user_graph = Koala::Facebook::API.new( fb_user_token )
    page_token = user_graph.get_page_access_token( fb_page_name )

    @page_graph = Koala::Facebook::API.new( page_token )
  end


  def publish(message, post_options)
    @page_graph.put_wall_post( message, post_options )
  end


  def fb_user_token
    ENV.fetch('FACEBOOK_ACCESS_TOKEN')
  end

  def fb_page_name
    ENV.fetch('FACEBOOK_PAGE')
  end

end
