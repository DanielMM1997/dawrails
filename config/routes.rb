Rails.application.routes.draw do
  root 'welcome#index', as: 'welcome'
  get 'welcome/index'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/registro', to: 'session#registro'
  get 'recientes', to: 'backgrounds#recientes'
  get 'destacados', to: 'backgrounds#destacados'
  post 'create_user_background', to: 'backgrounds#create_user_background'
  get '/logout' => 'users#logout'
  get 'admin/index'
  get 'admin/createUser', to: 'admin#newUser'
  get 'admin/createCategory', to: 'admin#newCategory'
  
  resources :backgrounds
  resources :categories
  resources :users
end
