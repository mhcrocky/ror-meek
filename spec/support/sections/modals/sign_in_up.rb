class SignInUp < SitePrism::Section
  element :sign_up_link, '.btn-signup', text: 'Setup A Free Account?'
  element :reconfirm_link, '.link', text: 'Resend Confirmation Email'
  element :forgot_password_link, '.link', text: 'Forgot Your Password?'
  element :email_field, 'input[name="email"]'
  element :password_field, 'input[name="password"]'
  element :confirmation_password_field, 'input[name="password_confirmation"]'
  element :submit, '.btn-submit'

  element :facebook, '.btn-facebook', text: 'facebook'
  element :twitter, '.btn-twitter', text: 'twitter'
end
