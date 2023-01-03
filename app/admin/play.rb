ActiveAdmin.register Play do
  config.sort_order = 'updated_at_desc'

  actions :index

  filter :user_id_blank, as: :boolean, label: 'Only Non LoggedIn Users'
  filter :user, collection: -> { User.all.map{ |u| [u.full_name_with_email, u.id] } }
  filter :media_type

  index do
    column :user do |play|
      play.user.full_name_with_email if play.user
    end

    column :media
    column :duration
    column :updated_at

    column :stopped_at do |play|
      play.stopped_at if play.media_type != 'RadioStation'
    end
  end

end
