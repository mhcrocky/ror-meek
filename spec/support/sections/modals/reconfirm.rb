class Reconfirm < SitePrism::Section
  element :email_field, 'input[name="user[email]"]'
  element :submit, '.btn-submit'
end
