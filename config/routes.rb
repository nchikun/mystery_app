Rails.application.routes.draw do
  # HTTPで/static_pages/homeのGETリクエストを受け取った場合の挙動
  # URLのヘルパー変数は下記の定義により自動的にstatic_pages_home_urlとして割り当てられる
  get 'static_pages/home'

  get 'static_pages/help'

  get 'static_pages/about'

  # HTTPの初期GETリクエストを受け取った場合の挙動（rootと書く）
  # rootは/ではなく#でつなげる
  # ヘルパー変数としてroot_urlが使用できる
  root 'static_pages#home'
end
