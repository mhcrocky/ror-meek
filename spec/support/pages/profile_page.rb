require_relative('../sections/main_header_section')
require_relative('../sections/header_page_section')
require_relative('../sections/modals/details_about_you')
require_relative('../sections/modals/account_details')

require_relative('../sections/shared/account_default_station')

class ProfilePage < SitePrism::Page
  set_url("/me{/slug}")

  section :main_header, MainHeaderSection, '#main-header'

  section :header_page, HeaderPage, '.header-page'

  element :flash_container, '#toast-container'

  element :details_about_you_button, '[ng-click="modal.editDetailsInfo()"]'
  element :account_details_button, '[ng-click="modal.editAccountInfo()"]'

  section :details_about_you, DetailsAboutYou, '.details-about-you'
  section :account_details, AccountDetails, '.account-details'

  section :default_station, AccountDefaultStation, '.default-station-wrapper'
end
