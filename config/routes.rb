Rails.application.routes.draw do
  # authenticate :user do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # end
  root 'static_pages#landing_page'
  get 'dashboard', to: 'static_pages#dashboard'

  resources :api_tokens, only: [:index, :create, :update]
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :posts, only: [:index, :show, :create, :update, :destroy]
        get "homedoc/index", to: "homedoc#index"
      end
    end
  end
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'users#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy] # Add :destroy action
    resources :likes, only: [:create]
  end

  namespace :api, defaults: { format: 'json' } do
    resources :users, only: [] do
      resources :posts, only: [:index] # API endpoint to list all posts for a user
    end

    resources :posts, only: [] do
      resources :comments, only: [:index, :create] # API endpoint to list comments for a post and add comments
    end
  end
end
