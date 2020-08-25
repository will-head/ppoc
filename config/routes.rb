Rails.application.routes.draw do
  get 'feed_translations/feeds'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
