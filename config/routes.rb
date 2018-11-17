Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'
  get 'homes/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :labs do
    resources :news
		resources :albums
    resources :works
    member do
      get 'people', to: 'people#index'
      get 'people/:user_id', to: 'people#show'
      get 'about'
      get 'contact'
    end
  end

  # oen_time_token
  post 'tokens/create', to: 'tokens#create'
  post 'tokens/destroy', to: 'tokens#destroy'
  post 'tokens/get', to: 'tokens#get'

end
