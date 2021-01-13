Rails.application.routes.draw do
  root 'welcome#index', as: 'welcome'
  get 'welcome/index'
  get '/login', to: 'session#login'
  get '/registro', to: 'session#registro'
  post '/session/checkLogin', to: 'session#checkLogin'
  get 'recientes', to: 'backgrounds#recientes'
  get 'destacados', to: 'backgrounds#destacados'
  # get 'api/v1/categories#findCategory/:id'
  # get "/categories/:id" => "api/v1/categories#findCategory"
  
  resources :backgrounds
  resources :categories
  resources :users
  # get 'getBackgrounds/:id', to: 'categories#findCategory', as: 'category'
end
