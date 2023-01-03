class MainHeaderSection < SitePrism::Section
  element :logo, 'a.logo'
  element :sign_in_button, '.icon-text', text: 'SIGN IN'
  element :logout_button, '.icon-text', text: 'Logout', visible: false
  element :search_form, '.header-search'
  element :search_input, '#search_input'
  element :search_submit, '.icon-search-header'
  element :head_avatar, '.header-item .user-avatar'
end
