Rails.application.routes.draw do
  get 'posts/:id/favorites', to: 'users#new'
  devise_for :users
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users do
    resources :follow_relationships, only: [:create, :destroy]
  end
end
