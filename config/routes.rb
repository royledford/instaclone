Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'

  # get 'static_pages/home'
  get '/help',   to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'

  # Users
  get 'signup',  to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users

  # handle login sessions
  get 'login',       to: 'sessions#new'
  post 'login',      to: 'sessions#create'
  delete 'logout',   to: 'sessions#destroy'


  resources :posts
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
