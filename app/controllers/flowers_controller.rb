class FlowersController < ApplicationController
  before_action :set_flower, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]
  before_action :ensure_correct_user, only: %i[ edit update destroy ]

  def index
    @flowers = Flower.all
    @q = Flower.ransack(params[:q])
    @flowers = @q.result(distinct: true).order("created_at desc")
    gon.flowers = @flowers.map do |flower|
      {
      id: flower.id,
      name: flower.name,
      latitude: flower.latitude,
      longitude: flower.longitude,
      image_url: rails_blob_url(flower.image)
    }
    end
  end

  def show
    @comments = @flower.comments
    @comment = @flower.comments.build
    if user_signed_in?
      @favorite = current_user.favorites.find_by(flower_id: @flower.id)
    else
      @favorite = nil
    end
  end

  def new
    @flower = Flower.new
  end

  def edit
  end

  def create
    @flower = current_user.flowers.build(flower_params)
    return render :new if params[:back]
    if @flower.save
      redirect_to flowers_path, notice: '画像を投稿しました'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @flower.update(flower_params)
        format.html { redirect_to flower_url(@flower), notice: "投稿を編集しました" }
        format.json { render :show, status: :ok, location: @flower }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flower.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @flower.destroy

    respond_to do |format|
      format.html { redirect_to flowers_url, notice: "投稿を削除しました" }
      format.json { head :no_content }
    end
  end

  private
  
  def set_flower
    @flower = Flower.find(params[:id])
  end

  def flower_params
    params.require(:flower).permit(:name, :description, :image, :address, :latitude, :longitude)
  end

  def ensure_correct_user
    @user = @flower.user
    unless @user == current_user
      redirect_to flowers_path, alert: "アクセス権限がありません。"
    end
  end
end
