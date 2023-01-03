ActiveAdmin.register ShareSchedule do
  permit_params :id, :hours, :minutes

  menu parent: 'Share'

  config.filters = false
  config.batch_actions = false
  config.sort_order = 'hours_asc'


  index title: 'Share Schedule List: (EDT – Eastern Daylight Time as 0:00)' do
    column :publish_time

    actions
  end

  show do
    attributes_table do
      row :publish_time
    end
  end

  form do |f|
    f.inputs 'Create Schedule: Each Day' do
      f.input :hours, as: :select, collection: 0..23, include_blank: false
      f.input :minutes, as: :select, collection: 0..59, include_blank: false
    end

    f.actions
  end
end
