require_relative('../sections/view_switcher_section')
require_relative('../sections/main_header_section')

class SearchPage < SitePrism::Page
  section :main_header, MainHeaderSection, '#main-header'

  element :search_view, '.list-box.grid-view'
end
