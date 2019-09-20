Rails.application.routes.draw do

  post '/login', to: 'auth#login'
  post 'signup', to: 'users#create'
  get '/profile', to: 'users#profile'
  
  resources :volunteers
  resources :users
  resources :jobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
