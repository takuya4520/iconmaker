Rails.application.routes.draw do
  # Defines the root path route ("/")
  root to: 'chats#index'
  resources :chats
  get 'search', to: 'chats#search'
end
