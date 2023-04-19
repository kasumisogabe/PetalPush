class CommentsController < ApplicationController
  before_action :set_flower, only: [:create, :edit, :update]
  before_action :check_comment_owner, only: [:edit, :update, :destroy]

  def create
    @comment = @flower.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'コメントが投稿されました'
    else
      flash[:notice] = 'コメントを投稿できませんでした...'
    end

    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to flower_path(@flower) }
      end
    end
  end

  def edit
    @comment = @flower.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end
  def update
    @comment = @flower.comments.find(params[:id])
      respond_to do |format|
        if @comment.update(comment_params)
          flash.now[:notice] = 'コメントが編集されました'
          format.js { render :index }
        else
          flash.now[:notice] = 'コメントの編集に失敗しました'
          format.js { render :edit }
        end
      end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
  def set_flower
    @flower = Flower.find(params[:flower_id])
  end

  def check_comment_owner
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      redirect_to flower_path(@flower), alert: 'アクセスが制限されています。'
    end
  end
end