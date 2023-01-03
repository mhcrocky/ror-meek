class ViewSwitcherSection < SitePrism::Section
  element :grid_button, '.switcher-item .icon-grid'
  element :list_button, '.switcher-item .icon-list'

  element :list_button_active, '.switcher-item.active .icon-list'
  element :grid_button_active, '.switcher-item.active .icon-grid'
end
