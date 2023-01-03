ActiveAdmin.register Feedback do
  actions :index, :show

  filter :email
  filter :name
  filter :body

  index do
    column :id
    column :email
    column :name
    column :created_at
    actions
  end

end