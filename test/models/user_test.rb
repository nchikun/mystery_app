=begin
Userは単にログインに必要な情報をまとめる。
Profileでユーザのプロフィール情報をまとめる。
⇒その際にどの項目が必須でどの項目が任意なのかどうか等をTDDする
=end

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "nchikun", email: "nchikun@gmail.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # name,emailの空白,nil制限について

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
    @user.name = nil
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
    @user.email = nil
    assert_not @user.valid?
  end

  # name,emailの文字長について

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  # emailのフォーマットについて

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # emailの一意性について

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    # emailは大文字小文字区別しないため
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  # passwordの制限について

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  # その他

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

end
