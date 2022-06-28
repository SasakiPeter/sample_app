class UsersController < ApplicationController
  def show
    # paramsはurlのやつ
    @user = User.find(params[:id])
    # debugger
  end

  def new
    # debugger
  end
end
