Rails.application.routes.draw do
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

  # resources でも定義されているので、2つのroutesがactionにひもづいてる
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # リソースとして扱うと、CRUDが生える
  # get→show,new,edit とか
  # get "users/new" ←不要になった
  resources :users
  resources :account_activations, only: [:edit]
end
