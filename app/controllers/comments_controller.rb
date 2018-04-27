class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]


  def create

    @announcement = Announcement.find(params[:announcement_id])
    @comment = @announcement.comments.new(comment_params)
    @comment.user = current_user


    respond_to do |format|
      if @comment.save
        format.html { redirect_to @announcement }
        format.js
      else
        format.html { render :new }
        format.js {render status:500}
      end
    end
  end


  def destroy
    @announcement = Announcement.find(params[:announcement_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @announcement }
      format.js
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :comment_id)
  end
end
