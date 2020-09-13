Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/', to: 'application#welcome' 
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  

  resources :users, only: [:new, :show, :create, :edit, :update, :destroy]
  resources :journeys do 
  resources :comments, only: [:new, :create, :show, :index]
  end

  delete '/logout', to: 'sessions#destroy'
  root 'application#welcome' 
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
