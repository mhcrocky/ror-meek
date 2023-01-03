class AccountDefaultStation < SitePrism::Section
  element :title, '.name'
  element :description, '.description'
  element :image, '.media-image'
end
