Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  namespace 'api' do
    namespace 'v1' do
      resources :backgrounds
      resources :categories
      resources :users
    end
  end
end
