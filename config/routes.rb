Rails.application.routes.draw do
  root to: 'users#index' # this will map the "https://<your-domain>/" URL
  
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/:user_id/posts', to: 'posts#index'
  get 'users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
end
