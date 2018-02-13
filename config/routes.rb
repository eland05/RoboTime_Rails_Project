Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #get '/auth/github/callback' => "omniauth_callbacks#github"
  root to: "static_pages#home"
end
