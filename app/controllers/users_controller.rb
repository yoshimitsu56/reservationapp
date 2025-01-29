class UsersController < ApplicationController

  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィール情報が変更されました。"
      redirect_to root_path
    else
      flash[:notice] = "プロフィール情報を更新できませんでした。"
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_image, :user_name, :user_introduction)
  end
end
