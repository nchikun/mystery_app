class SessionsController < ApplicationController

  def new
  end

  def create
    # formでparamに対するsessionに対するemailとpasswordがハッシュで入力されている
    user = User.find_by(email: params[:session][:email].downcase)
    # authenticateメソッドは入力から得たpasswordをハッシュ関数を通してtrue/false
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      # :remember_meはチェックボックスがオンの時に1,オフのときに0
      # digest生成で永続化するか否か
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      # フラッシュメッセージ（一度きりのメッセージ）
      # flash[]だとメッセージが残り続けるためflash.now[]を使用
      flash.now[:danger] = 'Invalid email/password combination'
      # newアクションを実行
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
