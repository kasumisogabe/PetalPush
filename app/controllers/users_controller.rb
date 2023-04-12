class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!
  before_action :current_user, only: [:show, :edit, :update]

  def show
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを編集しました！"
    else
      flash.now[:danger] = "プロフィールを更新できませんでした"
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image)
  end

  def currect_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, alert: "アクセス権限がありません。"
    end
  end
end
