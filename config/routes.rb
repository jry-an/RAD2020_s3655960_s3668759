Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users do
    resources :discussions, only: [:index]
    resources :replies, only: [:index]
  end
  get 'users/:id/user_posts' => 'users#user_posts', :as => :custom_user_posts
  get 'users/:id/user_replies' => 'users#user_replies', :as => :custom_user_replies

  resources :topics
  resources :discussions do
  	resources :replies
  end
  resources :discussions do
    member do
      get :users
    end
  end

  root 'discussions#index'

  devise_for :users, controllers: { registrations: 'registrations' }
end
