ActiveAdmin.register Footer do
  config.batch_actions = false
  config.filters = false
  
  menu parent: 'Customize'

  permit_params :title, :link, :position
end
