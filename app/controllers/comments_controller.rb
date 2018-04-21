class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy]


  def index
    @comment = Comment.order('created_at DESC')
  end

  def show

  end

  # GET /comments/new
  def new
    @annoucement = Annoucement.find(params[:annoucement_id])
    @comment = @annoucement.comments.new(params[:comment_params])
  end

  # def edit
  #
  # end

  def create

    @annoucement = Annoucement.find(params[:annoucement_id])
    @comment = @annoucement.comments.create(comment_params)
    @comment.user = current_user


    respond_to do |format|
      if @comment.save
        format.html { redirect_to @annoucement, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @comment.update(comment_params)
  #       format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @comment }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @annoucement = Annoucement.find(params[:annoucement_id])
    @comment = @annoucement.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to annoucement_path(@annoucement), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :user_id, :annoucement_id)
  end
end
