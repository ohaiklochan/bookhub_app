Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/', to: 'application#welcome' 
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'
  

  resources :users, only: [:new, :show, :create, :edit, :update, :destroy]
  resources :reviews do 
  resources :comments, only: [:new, :create, :show, :index]
  end

  delete '/logout', to: 'sessions#destroy'
  root 'application#welcome' 
end
