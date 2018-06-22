Rails.application.routes.draw do
  root to: "static_pages#home"
  resources :teams

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/users/auth/github/callback' => "omniauth_callbacks#github"
  resources :users, only: [:index, :show, :edit, :update]
end
