Rails.application.routes.draw do
  root "photos#index"

  devise_for :users

  

  # resources :users, only: :show
  
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos

  get ":username/likes" => "photos#likes", as: :liked_photos

  get ":username" => "users#show", as: :user

  get ":username/feed" => "photos#feed", as: :feed

  get ":username/followers" => "users#followers", as: :followers

  get ":username/following" => "users#leaders", as: :following

  get ":username/discover" => "photos#discover", as: :discover
end
