# sign up時の使用感についてのテスト

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  # POST無効テスト
  test "invalid signup information" do
    get signup_path

    # 当コードブロック実行後にUser数が増えないことを確認
    assert_no_difference 'User.count' do
      # usersのURLにparamsをPOST
      post users_path, params: {
        # user情報は抽象的なparamsハッシュのvalueとして含まれる
        user: {
          # さらにuserハッシュのvalueは以下の登録情報
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end

    # 有効でないためnewページへ
    assert_template 'users/new'
  end

  # POST有効テスト
  test "valid signup information" do
    get signup_path

    # 当コードブロック実行前後にUser.countの差分が1となることを確認
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    # 有効であるためshowページへ
    follow_redirect!
    assert_template 'users/show'
  end

end
