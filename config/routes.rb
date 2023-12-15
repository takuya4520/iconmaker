Rails.application.routes.draw do
  # Defines the root path route ("/")

  resources :chatbots

  root "chatbots#index"
  
end
