class UsersController < ApplicationController

=begin
/users/[id]の表示
show.html.erbを作成して@user.name,@user.emailを使用することで表示
=end
  def show
    @user = User.find(params[:id])
  end

=begin
新規作成ページ
新規作成時点ではユーザに何も紐づかない（@userはnil）
インスタンス生成（User.new）するだけ
=end
  def new
    @user = User.new
  end

=begin
newページでsubmitされた場合の挙動を定義
=end
  def create
    # params[:user]でmodelのユーザ情報を記載
    @user = User.new(user_params)
    if @user.save
      # flash変数は1度目しかされない表示を定義（:dangerハッシュも定義可能）
      flash[:success] = "Welcome to the Mystery!"
      redirect_to @user
    else
      # renderで遷移先を指定する（newだと結果的にnew.html.erbに遷移）
      render 'new'
    end
  end

  private

    # strong parameter（DB書き込みの制御）
    def user_params
      # newビューからの入力はname~password_confirmation以外許可しない
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation)
    end


end
