Rails.application.routes.draw do
  # rootのときは、関数を指定
  # rootに指定したurlはroot_urlとして使える模様
  root "static_pages#home"
  # なるほど、getのときは、urlをかけばいい
  # こちらのurlはstatic_pages_home_urlとして使える
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/contact"
end
