Rails.application.routes.draw do
  get 'sessions/new'

  # HTTPの初期GETリクエストを受け取った場合の挙動（rootと書く）
  # rootは/ではなく#でつなげる
  # ヘルパー変数としてroot_urlが使用できる
  root 'static_pages#home'

  # 静的ページ

  # HTTPで/static_pages/homeのGETリクエストを受け取った場合の挙動
  # URLのヘルパー変数は下記の定義により*_pathもしくは*_urlの変数が使用可能
  # 全て静的ページなのでpost,delete等のRESUfulは必要ない
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  # サインアップ,基本的にサインアップのnew,createアクションは同じview
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  # サインアップはRESTful
  resources :users

  # ログイン,基本的にログインのnew,createアクションは同じview
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

end
