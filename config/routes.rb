Rails.application.routes.draw do
  root to: "static_pages#home"
  resources :teams
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #get '/auth/github/callback' => "omniauth_callbacks#github"
  get 'profile', to: :show, controller: 'users'
end
