Rails.application.routes.draw do
  root 'welcome#index', as: 'welcome'
  get 'welcome/index'
  get 'admin/index'
  post '/search', to: 'backgrounds#search'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/registro', to: 'session#registro'
  get '/recientes', to: 'backgrounds#recientes'
  get '/allRecientes', to: 'backgrounds#allRecientes'
  get '/showAllRecientes', to: 'categories#showAllRecientes'
  get '/destacados', to: 'backgrounds#destacados'
  get '/allDestacados', to: 'backgrounds#allDestacados'
  get '/showAllDestacados', to: 'categories#showAllDestacados'
  get '/logout' => 'users#logout'
  get '/like/:id', to: 'backgrounds#like'
  get '/dislike/:id', to: 'backgrounds#dislike'
  
  resources :backgrounds
  resources :categories
  resources :users
end
