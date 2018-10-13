# すべてのViewで使用できるヘルパー関数モジュール
# モジュールなので便利関数を列挙する
module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'Hack Mystery'
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

end
