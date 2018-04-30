class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :any_group, only: [:index, :show]
  before_action :authenticate_user!

  def index
    @announcements = Announcement.all
    @announcement = Announcement.new
    @users_announcements = Announcement.left_outer_joins(group: :user_groups).where('user_groups.user_id = ?', current_user.id)
  end

  def show
    @comments = @announcement.comments
  end

  def new
  end

  def any_group
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
        format.html { redirect_to announcements_path}
        format.js
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render @announcement}
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

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :description, :city, :exp_date, :user_id, :group_id, :ann)
  end

end
