class SessionsController < ApplicationController
  def new
    # debugger
  end

  def create
    # 見つからないと、nilが返る
    # local変数ではなく、instance変数にすることで、テストからassigns(:user)で参照できる
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        # helperはcontrollerでも呼べる→なぜなら、include SessionsHelperしてるから
        log_in @user

        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        # 認証成功したら、個別ページにリダイレクトか、元のページに戻してあげる
        redirect_back_or @user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
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
