require_relative('../sections/main_header_section')
require_relative('../sections/sidebar_section')
require_relative('../sections/footer_section')
require_relative('../sections/modals/sign_in_up')
require_relative('../sections/modals/reconfirm')
require_relative('../sections/modals/reset_password')


class HomePage < SitePrism::Page
  set_url('/')
  set_url_matcher(/\//)

  section :main_header, MainHeaderSection, '#main-header'
  section :sidebar_nav, SidebarSection, '#side-navigation-wrapper'
  section :footer, FooterSection, '#footer'
  section :sign_modal, SignInUp, '.modal-sign'
  section :reconfirm_modal, Reconfirm, '.modal-reset'
  section :reset_password_modal, ResetPassword, '.modal-reset'

  element :flash_container, '#toast-container'

  element :recommended_header, '.recommended-header'

  element :recommended_radio_block, '.recommended-radiostations'
  element :recommended_podcast_block, '.recommended-podcasts'
  element :recommended_latest_episodes_block, '.recommended-latest-episodes'
  element :recommended_podcasts_to_try_block, '.recommended-podcasts-to-try'
  element :recent_episodes_block, '.recent-episodes'
end
