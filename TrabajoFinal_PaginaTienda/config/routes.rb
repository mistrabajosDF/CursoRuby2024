Rails.application.routes.draw do
  get "checkouts/create"
  devise_for :customers
  resources :products do
    collection do
      get 'special_view'
    end
  end
  resources :sales
  resources :users
  resource :user

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  
  root 'products#special_view'

  resources :products do
    member do
      get 'price'
    end
  end

   resource :cart, only: [:show] do
    resources :cart_items, only: [:create, :update, :destroy]
    delete 'clear', to: 'carts#clear'
  end

  post 'checkout', to: 'checkouts#create'

  resources :checkouts, only: [:new, :create]

  
  get '*path', to: 'errors#not_found', constraints: ->(req) { 
    !req.path.start_with?('/assets') && 
    !req.path.start_with?('/storage') && 
    !req.path.start_with?('/rails/active_storage') 
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
