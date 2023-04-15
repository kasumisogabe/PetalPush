class FlowersController < ApplicationController
  before_action :set_flower, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]

  # GET /flowers or /flowers.json
  def index
    @flowers = Flower.all
    @q = Flower.ransack(params[:q])
    @flowers = @q.result(distinct: true).order("created_at desc")
    gon.flowers = @flowers
  end

  # GET /flowers/1 or /flowers/1.json
  def show
    @comments = @flower.comments
    @comment = @flower.comments.build
    @favorite = current_user.favorites.find_by(flower_id: @flower.id)
  end

  # GET /flowers/new
  def new
    @flower = Flower.new
  end

  # GET /flowers/1/edit
  def edit
  end

  # POST /flowers or /flowers.json
  def create
    @flower = current_user.flowers.build(flower_params)
    return render :new if params[:back]
    if @flower.save
      redirect_to flowers_path, notice: '画像を投稿しました'
    else
      render :new
    end
  end

  # PATCH/PUT /flowers/1 or /flowers/1.json
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

  # DELETE /flowers/1 or /flowers/1.json
  def destroy
    @flower.destroy

    respond_to do |format|
      format.html { redirect_to flowers_url, notice: "投稿を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flower
      @flower = Flower.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flower_params
      params.require(:flower).permit(:name, :description, :image, :address, :latitude, :longitude)
    end
end
