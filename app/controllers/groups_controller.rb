class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join_group]
  before_action :authenticate_user!
  before_action :count_users, only: :index


  def index
    @groups = Group.paginate(page: params[:page], per_page: 12)
    @group= Group.new
  end

  def show
    @group_announcements = @group.announcements.paginate(page: params[:page], per_page: 15)
    @announcement = Announcement.new
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def leave_group
    @user_groups = UserGroup.find_by(user_id: current_user[:id], group_id: params[:id])
    @user_groups.destroy
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.js
    end

  end

  def join_group
    @user = User.find(current_user[:id])
    respond_to do |format|
      if @user.groups << @group
        format.html {redirect_to groups_path}
        format.js
      else
        format.html { render :index, danger: 'You\'re already in this group'}
      end
    end
  end

  def create
    @group = Group.new(group_params)
    @group.created_by = current_user.id
    @user_group_ids = current_user.user_groups.pluck(:group_id)


    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully saved.' }
        format.js
        format.json { render :index, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Group was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private

  def count_users
    @count_users = UserGroup.pluck(:group_id)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name, :group_id, :user_id, :created_by, :group_image)
  end
end
