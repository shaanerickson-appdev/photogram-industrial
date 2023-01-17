Rails.application.routes.draw do
  root "photos#index"

  devise_for :users

  

  # resources :users, only: :show
  
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos

  get "/:username" => "users#show"
end
