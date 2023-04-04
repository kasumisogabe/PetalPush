class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.create(flower_id: params[:flower_id])
    redirect_to flowers_path, notice: "#{favorite.flower.favorite_users.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to flowers_path, notice: "#{favorite.flower.favorite_users.name}さんのブログをお気に入り解除しました"
  end
end
