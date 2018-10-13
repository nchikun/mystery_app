require 'test_helper'

# 統合テストでユーザのアプリ使用感をテスト（単体テストと比較してテスト粒度は大きい）
class SiteLayoutTest < ActionDispatch::IntegrationTest

  # homeページでroot（2つ）,help,about,contactのパスが存在するか？
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end
