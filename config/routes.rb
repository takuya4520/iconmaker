Rails.application.routes.draw do
  # Defines the root path route ("/")
  root to: 'chats#index'
  resources :chats
  get 'search', to: 'chats#search'
  resources :images
  get 'create_icon', to: 'images#create_image'
end
