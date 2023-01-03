ActiveAdmin.register ChurchType do
  permit_params :id, :name

  filter :name
end
