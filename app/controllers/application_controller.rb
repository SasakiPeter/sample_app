class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # generate controller Sessions new して生成されたもの
  include SessionsHelper

  # def hello
  #   render html: "hello, world!"
  # end
end
