Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  current_api_routes = lambda do
    resources :feeds, only: [:create]
  end

  namespace :api do
    scope :module => :v1, &current_api_routes
    namespace :v1, &current_api_routes
  end
end
