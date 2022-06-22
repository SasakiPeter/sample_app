# ここは、application.html.erbで使えるヘルパー関数を定義するところ
# moduleはincludeで読み込み（mixed in）
# そうすると、中に定義した関数が、むき出しで使える
module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Ruby on Rails Tutorial Sample App"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  # def full_title(page_title = "")
  #   base_title = "Ruby on Rails Tutorial Sample App"
  #   return base_title if page_title.empty?
  #   page_title + " | " + base_title
  # end

  # def full_title(page_title = "")
  #   base_title = "Ruby on Rails Tutorial Sample App"
  #   if page_title.empty?
  #     base_title # 暗黙return
  #   else
  #     page_title + " | " + base_title
  #   end
  # end
end
