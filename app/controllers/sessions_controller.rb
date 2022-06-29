class SessionsController < ApplicationController
  def new
  end

  def create
    # 見つからないと、nilが返る
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 認証成功したら、個別ページにリダイレクト
      redirect_to user
    else
      # .nowをつけると、次のリクエストで消滅する
      flash.now[:danger] = "Invalid email/password combination"
      # redirect_to login_path
      render "new"
    end
  end

  def destroy
  end
end
