Rails.application.routes.draw do
  root "sessions#home"

  # signup
  get "/signup" => "users#new"
  # if a user signs up incorrectly the url re-renders as /signup
  post "/signup" => "users#create"

  # login
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"

  # logout
  delete "/logout" => "sessions#destroy"

  # omniauth callback routes
  get "/auth/:provider/callback" => "sessions#omnilogin"

  resources :reviews, :books
  resources :authors, only: [:destroy]
  resources :authors, only: [:index]
  resources :readers, only: [:show]
  resources :books, :users, only: [:show] do
    resources :reviews, shallow: true
  end
  resources :authors, only: [:show] do
    resources :bookss, only: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
