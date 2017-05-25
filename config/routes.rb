Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "pages#home"
  get 'pages/home' , to: 'pages#home'
  
  resources :companies do
  	resources :positions
  end
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users, except: [:new]

  #resources :positions

  #get '/companies', to: 'companies#index'
  
  #get '/companies/new', to: 'companies#new', as: 'new_company'
  #get '/companies/:id', to: 'companies#show', as: 'company'
  #post '/companies', to: 'companies#create'
end
