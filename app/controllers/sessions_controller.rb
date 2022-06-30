class SessionsController < ApplicationController
  def new
  end

  def create
    # 見つからないと、nilが返る
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # helperはcontrollerでも呼べる→なぜなら、include SessionsHelperしてるから
      log_in user

      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      # 認証成功したら、個別ページにリダイレクト
      redirect_to user
    else
      # .nowをつけると、次のリクエストで消滅する
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
