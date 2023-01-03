require_relative('../sections/main_header_section')
require_relative('../sections/sidebar_section')
require_relative('../sections/footer_section')
require_relative('../sections/modals/sign_in_up')
require_relative('../sections/modals/reconfirm')
require_relative('../sections/modals/reset_password')


class SignUpPage < SitePrism::Page
  set_url('/setup')

  section :main_header, MainHeaderSection, '#main-header'
  section :sidebar_nav, SidebarSection, '#side-navigation-wrapper'
  section :footer, FooterSection, '#footer'

  element :email_field, 'input[name="email"]'
  element :first_name_field, 'input[name="first_name"]'
  element :last_name_field, 'input[name="last_name"]'
  element :password_field, 'input[name="password"]'
  element :confirmation_password_field, 'input[name="password_confirmation"]'
  element :submit, '.btn-submit'
end
