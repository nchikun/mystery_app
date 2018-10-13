require 'test_helper'

# ユーザの使用感に合わせたテストを実装前に実施する
class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  # テストのためのヘルパー変数
  def setup
    @base_title = "Hack Mystery"
  end

  # /static_pages/homeに対するテスト
  test "should get home/root" do
    # /static_pages/homeのGETリクエストを送信
    get root_path
    # 上記リクエストに対してステータスコードが200（成功）であることを確認
    assert_response :success
    # セレクタは指定ページにタグの存在と内容の一致を確認（titleタグとその中身）
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
