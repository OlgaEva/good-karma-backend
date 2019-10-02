Rails.application.routes.draw do

  post '/login', to: 'auth#login'
  post 'signup', to: 'users#create'
  get '/profile', to: 'users#profile'
  post '/favorites', to: 'favorites#create'
  post '/histories', to: 'histories#create'
  patch '/favorites', to: 'favorites#update'
  patch '/users', to: 'users#update'
  post './jobs', to: 'jobs#create'
  patch './jobs', to: 'jobs#update'
  delete './jobs', to: 'jobs#destroy'
  post './messages', to: 'messages#create'
  get './messages', to: 'messages#index'
  patch '/messages', to: 'messages#update'
  # get './favorites', to: 'favorites#index'

  resources :volunteers
  resources :users
  resources :jobs
  resources :favorites
  resources :messages
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
