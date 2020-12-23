Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do
      resources :backgrounds
      resources :categories
      resources :tags
    end
  end
end
