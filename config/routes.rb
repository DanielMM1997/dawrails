Rails.application.routes.draw do
  root 'welcome#index', as: 'welcome'
  get 'welcome/index'
  # get 'api/v1/categories#findCategory/:id'
  # get "/categories/:id" => "api/v1/categories#findCategory"
  
  resources :backgrounds
  resources :categories
  resources :users
  # get 'getBackgrounds/:id', to: 'categories#findCategory', as: 'category'
end
