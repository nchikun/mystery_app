=begin
・ログインするということはsessionのuser_idキーにバリューが入ることと定義
・ログイン状態にあるかということはuserの情報が取得できることと定義
=end

module SessionsHelper

  # ログイン状態か否か？
  def logged_in?
    # ログインの状態 = ユーザ情報がDBから取得できること
    !current_user.nil?
  end

  # ユーザ情報をDBから取得
  def current_user
    # ユーザ情報がDBから取得できること = ログインが成功していること
    if session[:user_id]
      # インスタンス変数として何度もfind_byしない
      @current_user ||= User.find_by(id: session[:user_id])
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
    session.delete(:user_id)
    @current_user = nil
  end

end
