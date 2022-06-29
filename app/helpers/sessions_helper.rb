module SessionsHelper
  def log_in(user)
    # 一時cookiesのため、ブラウザを閉じると有効期限終了（削除はされない?
    # cookiesから盗まれても、ログインできない
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
