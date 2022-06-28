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
    else
      render "new"
    end
  end

  private

  def user_params
    # params[:user]だと、他の属性に値を設定したrequestを受け取ってしまう
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
