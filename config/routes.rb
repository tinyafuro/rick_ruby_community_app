Rails.application.routes.draw do
  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :communities
  resources :community_joins, only: [:create, :destroy]
  
  resources :users do
    member do
      get :following
    end
  end

  



  # resources :communities, only: [:create, :destroy]
  # resources :communities, only: [:index, :show, :create, :destroy]
  
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'
  
end
