Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'
  get 'homes/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :labs do
    resources :news
		resources :albums
    resources :works
    # member do
    get '/about/:id', to: 'labs#about', as: 'about'
    get 'people/:id', to: 'labs#people', as: 'people'
    get 'contact/:id', to: 'labs#contact', as: 'contact'
    # end
  end

end
