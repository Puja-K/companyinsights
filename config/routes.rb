Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "pages#home"
  get 'pages/home' , to: 'pages#home'
  
  resources :companies do
  	resources :positions

  end

  resources :positions do
  	collection do
  		get 'search'
  	end
  end

  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, except: [:new]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get '/auth/:provider/callback', to: 'oauths#create'
  get '/auth/failure', to: 'oauth#failure', as: 'oauth_failure'
  
  #resources :positions

  #get '/companies', to: 'companies#index'
  
  #get '/companies/new', to: 'companies#new', as: 'new_company'
  #get '/companies/:id', to: 'companies#show', as: 'company'
  #post '/companies', to: 'companies#create'
end
