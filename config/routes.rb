Rails.application.routes.draw do
  resources :works
  devise_for :users
  root to: 'homes#index'
  get 'homes/show'
  resources :news
  resources :labs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :labs do
    resources :news
    resources :albums
  end

end
