Rails.application.routes.draw do
  # Defines the root path route ("/")
  root to: 'images#index'
  get 'create_icon', to: 'images#create_image'
end
