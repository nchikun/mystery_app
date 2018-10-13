# 静的ページは基本的にメソッドの中身は書かない
class StaticPagesController < ApplicationController

  # /static_pages/homeというGETリクエストに対して実行される
  # homeメソッドではhome.html.erbのViewで使用する変数を定義する（StaticPageだから定義しない？）
  # homeメソッドの実行後にhome.html.erbがブラウザで表示される
  def home
  end

  # /static_pages/helpというGETリクエストに対して実行される
  # helpメソッドではhelp.html.erbのViewで使用する変数を定義する（StaticPageだから定義しない？）
  # helpメソッドの実行後にhelp.html.erbがブラウザで表示される
  def help
  end

  def about
  end

  def contact
  end

end
