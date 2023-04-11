class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @favorites = current_user.favorites
    # flowerの情報が入っていないとダメ
    @favorites = current_user.favorite_flowers
  end

  def create
    favorite = current_user.favorites.create(flower_id: params[:flower_id])
    redirect_to flower_path(favorite.flower_id)
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to flower_path(favorite.flower_id)
  end
end
