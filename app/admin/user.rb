ActiveAdmin.register User do
  permit_params :id, :email, :first_name, :last_name, :password, :password_confirmation

  actions :all, except: [:new, :create]

  filter :email
  filter :first_name
  filter :last_name
  filter :weekly_emails_subscriptions

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :last_sign_in_at
    column :created_at
    actions
  end

  show do
    attributes_table 'User Details' do
      row :id
      row :email
      row :first_name
      row :last_name
      row :profile_pic do
        user.profile_pic.present? ? image_tag(user.profile_pic.url(:normal)) : 'N/A'
      end
      row :background_pic do
        user.background_pic.present? ? image_tag(user.background_pic.url) : 'N/A'
      end
      row :background_color
      row :weekly_emails_subscriptions
    end

    panel 'Plays' do
      table_for user.plays.order(created_at: :desc).limit(5) do
        column :media
        column :duration
        column :created_at
        column :stopped_at
      end

      div do
        link_to 'View All', admin_plays_path(q: { user_id_eq: user.id })
      end
    end

    panel 'Audits' do
      table_for user.audits.order(created_at: :desc).limit(5) do
        column :action
        column :ip
        column :created_at
      end

      div do
        link_to 'View All', admin_audits_path(q: { user_id_eq: user.id })
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :first_name
      f.input :last_name
    end

    f.inputs 'Password' do
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end

  controller do

    # Remove password parameters if blank.
    def update
      if params[:user][:password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end

      super
    end

  end

end
