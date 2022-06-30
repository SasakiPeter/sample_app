class UsersController < ApplicationController
  def show
    # paramsはurlのやつ
    @user = User.find(params[:id])
    # debugger
  end

  def new
    @user = User.new
    # debugger
  end

  def create
    # debugger
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # redirect_to user_url(@user)
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def user_params
    # params[:user]だと、他の属性に値を設定したrequestを受け取ってしまう
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
