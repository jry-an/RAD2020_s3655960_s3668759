Rails.application.routes.draw do
  
  resources :topics
  resources :discussions do
  	resources :replies
  end

  root 'discussions#index'

  devise_for :users, controllers: { registrations: 'registrations' }
end
