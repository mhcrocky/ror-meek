class ResetPassword < SitePrism::Section
  element :sign_in_link, '.link', text: 'Go to Sign in'
  element :email_field, 'input[name="user[email]"]'
  element :submit, '.btn-submit', text: 'Reset now'
end
