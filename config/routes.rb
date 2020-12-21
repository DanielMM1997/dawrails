Rails.application.routes.draw do
  get 'prueba1/index'
  get 'prueba/index'
  root :to => "welcome#index"
  get 'welcome/index'

  namespace 'api' do
    namespace 'v1' do
      resources :backgrounds
      resources :categories
      resources :tags
    end
  end
end
