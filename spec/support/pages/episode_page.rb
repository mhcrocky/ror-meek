require_relative('../sections/main_header_section')
require_relative('../sections/social_list_section')
require_relative('../sections/player_section')

class EpisodePage < SitePrism::Page
  set_url("{/category_slug}{/slug}{/episode_slug}")

  section :main_header, MainHeaderSection, '#main-header'
  section :soc_list, SocialListSection, '.list-soc'
  section :player, PlayerSection, '#meek-player'

  element :header_page_image, '.header-page>.header-page-image'
  element :flash_container, '#toast-container'
end
