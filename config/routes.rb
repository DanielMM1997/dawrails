Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  # get 'api/v1/categories#findCategory/:id'
  # get "/categories/:id" => "api/v1/categories#findCategory"
  

  namespace 'api' do
    namespace 'v1' do
      resources :backgrounds
      resources :categories
      resources :users
      # get 'getBackgrounds/:id', to: 'categories#findCategory', as: 'category'
    end
  end
end
