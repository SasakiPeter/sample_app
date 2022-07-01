module SessionsHelper
  def log_in(user)
    # 一時cookiesのため、ブラウザを閉じると有効期限終了（削除はされない?
    # cookiesから盗まれても、ログインできない
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if (user_id = session[:user_id])
      # 一時セッション
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      # # ここのtestが忘れているか検証のために、raiseを仕込む
      # raise
      # 永続セッション
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    # digest削除
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    # クッキーの削除
    forget(current_user)
    # セッションの削除
    session.delete(:user_id)
    # moduleの呼び出し先のメンバ変数として生えている？
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
