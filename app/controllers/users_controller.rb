class UsersController < ApplicationController
  # editとupdateのメソッドを使用する前にlogged_in_userメソッドを実行
  # before_action(メソッド,権限付与のオプションハッシュ)
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

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
      # ログインも同時に実施
      log_in @user
      # flash変数は1度目しかされない表示を定義（:dangerハッシュも定義可能）
      flash[:success] = "Welcome to the Mystery!"
      redirect_to @user
    else
      # renderで遷移先を指定する（newだと結果的にnew.html.erbに遷移）
      render 'new'
    end
  end

  # PATCHアクション（既に情報生成済みのモデルに対する編集POST）
  # PATCHは@userがnew_record?メソッドでfalseとなる場合（trueはPOST）
  def edit
    # :idをブラウザ上から取得→DBから情報引出し→インスタンス変数格納
    # edit.html.erbに@userを引き渡し
    @user = User.find(params[:id])
  end

  # editはnewに対する既存ユーザか否か
  # updateはcreateに対する既存ユーザか否か
  def update
    @user = User.find(params[:id])

    # ユーザ情報が更新できた場合
    if @user.update_attributes(user_params)
      # 成功のフラッシュメッセージ情報を格納
      flash[:success] = "プロフィールを更新しました!"
      redirect_to @user
    # ユーザ情報が更新できない場合（情報が不正な場合）
    else
      render 'edit'
    end
  end

  def index
    # paginateでparamsのページキーから取得できる:pageは自動生成されている
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy # user = User.find => user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    # strong parameter（DB書き込みの制御）
    def user_params
      # newビューからの入力はname~password_confirmation以外許可しない
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation)
    end

    # beforeアクション

    # ログイン状態でない場合はeditとupdateメソッドは使用できない
    def logged_in_user
      unless logged_in?
        store_location
        # フラッシュメッセージを保持してlogin_urlに移動
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
