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
      redirect_to user
    else
      # フラッシュメッセージ（一度きりのメッセージ）
      # flash[]だとメッセージが残り続けるためflash.now[]を使用
      flash.now[:danger] = 'Invalid email/password combination'
      # newアクションを実行
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
