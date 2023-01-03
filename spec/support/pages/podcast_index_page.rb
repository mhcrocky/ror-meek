require_relative('../sections/view_switcher_section')

class PodcastIndexPage < SitePrism::Page
  set_url("{/slug}")

  section :view_switcher, ViewSwitcherSection, '.switcher-wrapper'

  element :list_view, '.list-box.list-view'
  element :grid_view, '.list-box.grid-view'
end
