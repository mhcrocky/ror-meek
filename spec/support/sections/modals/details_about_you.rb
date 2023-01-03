class DetailsAboutYou < SitePrism::Section
  element :year, '#birthdate-year'
  element :month, '#birthdate-month'
  element :day, '#birthdate-day'

  element :submit, '.btn-submit'
end
