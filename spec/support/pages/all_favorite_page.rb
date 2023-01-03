require_relative('../sections/header_page_section')

class AllFavoritePage < SitePrism::Page
  set_url('/favorite')

  section :header_page, HeaderPage, '.header-page'

  element :list_view, '.list-box.list-view'
  element :grid_view, '.list-box.grid-view'
end
