Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'

  # get 'static_pages/home'
  get '/help',   to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'

  # Users
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users

  # handle login sessions
  get 'login',   to: 'sessions#new'
  get 'login',   to: 'sessions#create'
  get 'login',   to: 'sessions#destroy'


  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
