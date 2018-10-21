Rails.application.routes.draw do
  # HTTPの初期GETリクエストを受け取った場合の挙動（rootと書く）
  # rootは/ではなく#でつなげる
  # ヘルパー変数としてroot_urlが使用できる
  root 'static_pages#home'

  # 静的ページ

  # HTTPで/static_pages/homeのGETリクエストを受け取った場合の挙動
  # URLのヘルパー変数は下記の定義により*_pathもしくは*_urlの変数が使用可能
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  # 動的ページ（controller名#アクション（メソッド）名）
  get  '/signup',  to: 'users#new' #signup_path
  post '/signup',  to: 'users#create'

=begin
usersに対してRESTfulアクションを完備（/users/1等のページ）
e.g. 特定ユーザ表示（/users/1等）はshowアクション（show.html.erb）
=end
  resources :users

end
