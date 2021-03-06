class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :any_group
  before_action :authenticate_user!
  before_action :users_groups, only: [:update, :create]



  def index
    @announcement = Announcement.new
    @announcements = Announcement.user_groups_announcements(current_user).paginate(page: params[:page], per_page: 15)
  end

  def show
    @comments = @announcement.comments
  end

  def new
  end



  def edit; end

  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.user = current_user

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement}
        format.js
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render @announcement}
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to announcements_path, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: 'Announcement was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private

  def any_group
    unless Group.user_in_any_group?(current_user).exists?
      redirect_to groups_path
    end
  end

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :description, :city, :exp_date, :user_id, :group_id)
  end

  def count_comments
    @count_comments = Comment.pluck(:announcement_id).count
  end
end
