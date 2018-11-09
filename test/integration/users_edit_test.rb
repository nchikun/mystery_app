require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    # @userに関するeditページのGETリクエスト（ログイン必須）
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    # PATCHリクエストで@userを更新する（nameがないためエラー）
    patch user_path(@user), params: {
      user: {
        name: "",
        email: "foo@invalid",
        password: "foo",
        password_confirmation: "bar"
      }
    }
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {
      user: {
        name:  name,
        email: email,
        password:              "", # なくても通るようにする
        password_confirmation: ""  # なくても通るようにする
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user # プロフィールページに戻る
    @user.reload # ???
    assert_equal name,  @user.name # nameが登録できたことの確認
    assert_equal email, @user.email # emailが登録できたことの確認
  end

end
