class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @flowers = @user.flowers.order("created_at desc")
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
      bypass_sign_in(@user) if params[:user][:password].present?
      redirect_to user_path(@user), notice: "プロフィールを編集しました！"
    else
      flash.now[:danger] = "プロフィールを更新できませんでした"
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to flowers_path, alert: "アクセス権限がありません。"
    end
  end
end