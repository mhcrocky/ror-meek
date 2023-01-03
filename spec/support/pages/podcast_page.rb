require_relative('../sections/main_header_section')
require_relative('../sections/social_list_section')
require_relative('../sections/player_section')

class PodcastPage < SitePrism::Page
  set_url("{/category_slug}{/slug}")

  section :main_header, MainHeaderSection, '#main-header'
  section :soc_list, SocialListSection, '.list-soc'
  section :player, PlayerSection, '#meek-player'

  section :podcast, '#inside-page' do
    element :play_button, '#inside-page .btn-play-media'

    element :title, '#inside-page .header-page .title'
    element :short_description, '#inside-page>.title'
    element :description, '#inside-page>.description'
    element :logo, '#inside-page>.description img'

    element :wallpaper, '#inside-page>.description img'
  end

  section :episodes, '.list-media-line' do
    sections :media_item, '.list-media-line-item' do
      element :title, '.name a.title'
      element :release_date, '.date'
      element :details, '.media-item .media-item-show'
    end
  end

  element :header_page_image, '.header-page>.header-page-image'
  element :flash_container, '#toast-container'

end
