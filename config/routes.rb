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
      get 'about'
      get 'people'
      get 'contact'
    end
  end

end
