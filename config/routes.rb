Rails.application.routes.draw do
  get 'invites/new'
  get 'invites/create'
  get 'invites/confirm'
  get 'invites/complete'
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
      get 'invites/new', to: 'invites#new'
      post 'invites', to: 'invites#create'
    end
  end

  # oen_time_token
  post 'tokens', to: 'tokens#create'
  delete 'tokens', to: 'tokens#destroy'
  post 'tokens/get', to: 'tokens#get'

  # 開発時のメール確認
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
