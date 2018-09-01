Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'
  get 'homes/show'
  resources :news
  resources :labs
end
