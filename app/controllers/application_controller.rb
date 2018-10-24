# 全コントローラクラスの親クラス
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # SessionsHelperクラスの変数とメソッドは全コントローラで使用可能とする
  include SessionsHelper
end
