Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/', to: 'application#welcome' 
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  # review nested routes --> add nested routes
  # nested index, nested show, nested new

  resources :users, only: [:new, :show, :create, :edit, :update, :destroy]
   # be curious about this resource
  resources :reviews do 
    resources :comments, only: [:new, :create, :show, :index]
    # get 'reviews/:id/comments' to: 'comments#index'
    # get 'reviews/new' to: 'reviews#new'
  end

  delete '/logout', to: 'sessions#destroy'
  root 'application#welcome' 
end
