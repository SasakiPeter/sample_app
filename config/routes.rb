Rails.application.routes.draw do
  # なるほど、getのときは、urlをかけばいい
  get "static_pages/home"
  get "static_pages/help"
  root "application#hello"
end
