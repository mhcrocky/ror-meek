class SocialListSection < SitePrism::Section
  element :add_to_favorites, '.add-favourite'
  element :set_as_default, '.add-default'

  element :share_on_facebook, '.icon-facebook'
  element :share_by_twitter, '.icon-twitter'
  element :share_by_googleplus, '.icon-googleplus'
  element :share_by_pinterest, '.icon-pinterest'

  element :share_by_email, '.soc-email'
end
