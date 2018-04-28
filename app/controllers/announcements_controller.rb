class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :youre_not_in_any_group, only: [:index, :show]


  def index

    @announcement = Announcement.new
    @users_announcements = Announcement.left_outer_joins(group: :user_groups).where('user_groups.user_id = ?', current_user.id)
  end

  def show
    @comments = @announcement.comments
  end

  def new
  end

  def youre_not_in_any_group
    unless UserGroup.where("user_id = ?",  current_user.id).exists?
      redirect_to groups_path
    end
  end

  def edit; end

  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.user = current_user

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement }
        format.js
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render announcements_path}
        format.js
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to announcements_url, notice: 'Announcement was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
      format.js
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

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :description, :city, :exp_date, :user_id, :group_id, :ann)
  end

  def require_same_user
    if current_user != @announcement.user
      flash[:danger] = 'You can only edit or delete your own article'
      redirect_to @announcement
    end
  end
end
