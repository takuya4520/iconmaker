Rails.application.routes.draw do
  get 'login', to: 'user_sessions#new' #login_pathが使えるようになり、login_pathが使われるとログイン画面（'user_sessions#new'）に移動する
  post 'login', to: 'user_sessions#create' #login_path('user_sessions#new')からのデータを'user_sessions#create'へ受け取って、データベースに保存
  delete 'logout', to: 'user_sessions#destroy' #logout_pathが使えるようになる。削除処理を行う。

  resources :users, only: %i[new create]
  # Defines the root path route ("/")
  root to: 'images#top'
  get 'create_icon', to: 'images#create_image'
end
