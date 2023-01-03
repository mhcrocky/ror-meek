require 'resque_web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'application#index'

  #ActiveAdmin.routes(self)

  authenticate :admin_user do
    mount ResqueWeb::Engine => '/resque'
  end

  devise_for :users, path_prefix: 'api', controllers: {
    omniauth_callbacks: 'api/devise/omniauth_callbacks',
    confirmations: 'api/devise/confirmations'
  }

  namespace 'api' do
    resource :play, only: [:create, :update]
    resources :backgrounds, :static_pages, :landing_pages, only: :show
    resources :categories, :countries, :regions, only: [:index, :show]
    resources :church_types, only: :index

    resource :feedback, only: [:create]
    resource :invitation, only: [:create, :edit, :update]
    resource :notification, only: [:create]

    resources :podcasts, only: [:index, :show] do
      resources :episodes, only: [:index, :show]
    end

    resources :articles, only: [:index, :show] do
      resources :posts, only:[:index, :show]
    end

    namespace :trends do
      resources :episodes, only: :index
      resources :latest_episodes, only: :index
      resources :podcasts_to_try, only: :index
      resources :articles_to_try, only: :index
      resources :posts, only: :index
    end

    resource :unsubscribe, only: [:update]

    namespace 'user' do
      resource :account, only: [:update] do
        collection do
          put 'update_password'
        end
      end

      resources :favorites, only: [:show, :create, :destroy]

      namespace 'favorite' do
        resources :episodes, only: [:index]
        resources :podcasts, only: [:index]
        resources :articles, only: :index
      end

      namespace 'recent' do
        resources :episodes, :posts, :recent_episodes, only: [:index]
      end
    end

    namespace 'search' do
      resource :searches, only: :show
    end
  end

  get 'sitemap.xml' => 'robots/sitemap#sitemap'
  get 'robots.txt' => 'robots/specification#allow_access_with_sitemap'

  get '*path' => 'application#index'
end
