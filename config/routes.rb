Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  resources :users
  resources :friends
  resources :friend_requests
  resources :likes,    only: %i[create destroy]
  resources :posts,    only: %i[create destroy show] do
    resources :comments, only: %i[create destroy]
  end
  root to: 'static_pages#home'
end
