=begin
・ログインするということはsessionのuser_idキーにバリューが入ることと定義
・ログイン状態にあるかということはuserの情報が取得できることと定義
=end

module SessionsHelper

  # ログイン状態か否か？（他にはどういう状態と解釈できるか？）
  def logged_in?
    # ログインの状態 = ユーザ情報がDBから取得できること
    !current_user.nil?
  end

  # ユーザ情報をDBから取得
  def current_user
    # sessionがuser_idを保持
    if (user_id = session[:user_id])
      # DBからの抽出処理を削減するためインスタンス変数で持つ
      @current_user ||= User.find_by(id: user_id)
    # cookiesはuser_idを保持
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ログインする
  def log_in(user)
    # ログインする = sessionハッシュのuser_idバリューが入っていること
    session[:user_id] = user.id
  end

  # ログアウト
  def log_out
    # ログアウト = sessionにもuserにも値が入っていない状態
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # セッションの永続化（cookiesへのuser_id保持）
  def remember(user)
    user.remember
    # ブラウザを閉じたあとでもサーバ側で持つ情報（cookieを利用）
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # 永続的セッションを破壊する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
