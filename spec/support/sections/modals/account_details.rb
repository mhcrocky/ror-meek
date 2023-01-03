class AccountDetails < SitePrism::Section
  element :email,      '#user-email'
  element :first_name, '#user-first-name'
  element :last_name,  '#user-last-name'

  element :submit, '.btn-submit', text: 'Save'
  element :update_password, '.btn-submit', text: 'Update Password'
end
