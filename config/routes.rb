Rails.application.routes.draw do
  root 'welcome#index', as: 'welcome'
  get 'admin/index'
  post '/search', to: 'backgrounds#search'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/recientes', to: 'backgrounds#recientes'
  get '/allRecientes', to: 'backgrounds#allRecientes'
  get '/showAllRecientes', to: 'categories#showAllRecientes'
  get '/destacados', to: 'backgrounds#destacados'
  get '/allDestacados', to: 'backgrounds#allDestacados'
  get '/showAllDestacados', to: 'categories#showAllDestacados'
  get '/like/:id', to: 'backgrounds#like', as: 'like'
  get '/dislike/:id', to: 'backgrounds#dislike', as: 'dislike'
  post 'create_user_background', to: 'backgrounds#create_user_background'
  get '/logout' => 'users#logout'
  get 'admin/createUser', to: 'admin#newUser'
  post 'create_user_admin', to: 'admin#createUser'
  
  resources :backgrounds
  resources :categories
  resources :users
end
