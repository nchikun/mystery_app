require 'test_helper'

# ユーザの使用感に合わせたテストを実装前に実施する
class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  # テストのためのヘルパー変数
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  # /static_pages/homeはルートでも参照されることの確認
  test "should get root" do
    get root_url
    assert_response :success
  end

  # /static_pages/homeに対するテスト
  test "should get home" do
    # /static_pages/homeのGETリクエストを送信
    get static_pages_home_url
    # 上記リクエストに対してステータスコードが200（成功）であることを確認
    assert_response :success
    # セレクタは指定ページにタグの存在と内容の一致を確認（titleタグとその中身）
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

end
