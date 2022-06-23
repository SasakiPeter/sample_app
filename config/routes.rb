Rails.application.routes.draw do
  get "users/new"
  # rootのときは、関数を指定
  # rootに指定したurlはroot_urlとして使える模様
  root "static_pages#home"
  # なるほど、getのときは、urlをかけばいい
  # こちらのurlはstatic_pages_home_urlとして使える
  # get "static_pages/help"
  # as: "hoge" で*_urlや、*_pathの名前が変更できる
  # もちろんこれらは、hashなので、:as => "hoge" のようにもかける
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
end
