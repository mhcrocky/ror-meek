ActiveAdmin.register Stylesheet do
    config.batch_actions = false
    config.filters = false
  
    menu parent: 'Customize'
  
    permit_params :name, :body
end
