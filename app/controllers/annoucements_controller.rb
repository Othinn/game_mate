class AnnoucementsController < ApplicationController
  before_action :set_annoucement, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]



  def index
    @annoucement = Annoucement.paginate(page: params[:page], per_page: 9)
  end

  def show

  end

  # GET /annoucements/new
  def new
    @annoucement = Annoucement.new
  end

  def edit; end

  def create
    @annoucement = Annoucement.new(annoucement_params)
    @annoucement.user = current_user

    respond_to do |format|
      if @annoucement.save
        format.html { redirect_to @annoucement, notice: 'Annoucement was successfully created.' }
        format.json { render :show, status: :created, location: @annoucement }
      else
        format.html { render :new }
        format.json { render json: @annoucement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @annoucement.update(annoucement_params)
        format.html { redirect_to annoucements_url, notice: 'Annoucement was successfully updated.' }
        format.json { render :show, status: :ok, location: @annoucement }
      else
        format.html { render :edit }
        format.json { render json: @annoucement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @annoucement.destroy
    respond_to do |format|
      format.html { redirect_to annoucements_url, notice: 'Annoucement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


  def require_user
    unless user_signed_in?
      flash[:danger] = 'You need to be logged in to perform that action'
      redirect_to home_index_path
    end
  end

  def set_annoucement
    @annoucement = Annoucement.find(params[:id])
  end

  def annoucement_params
    params.require(:annoucement).permit(:title, :description, :city, :exp_date, :user_id, :group_id)
  end

  def require_same_user
    if current_user != @annoucement.user
      flash[:danger] = 'You can only edit or delete your own article'
      redirect_to @annoucement
    end
  end
end
