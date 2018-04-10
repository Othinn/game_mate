class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def leave_group
    @user_groups = UserGroup.find_or_create_by(user_id: current_user[:id], group_id: params[:id])
    @user_groups.destroy
    redirect_to groups_path
  end

  def join_group
    @user = User.find(current_user[:id])
    @group = Group.find(params[:id])
    @user.groups << @group
    flash[:notice] = 'Joined to group'
    redirect_to groups_path
  end

  # def user_groups
  #   @user_groups = UserGroup.where(user_id: current_user.id)
  #   project_ids = []
  #   @user_groups.each do |member|
  #     project_ids << member.group_id
  #   end
  #   @groups = Group.where(id: project_ids)
  # end

  def create
    @group = Group.new(group_params)
    @group.created_by = current_user.id

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
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
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
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
      format.json { head :no_content }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name, :group_id, :user_id, :created_by)
  end

  def require_user
    unless user_signed_in?
      flash[:danger] = 'You need to be logged in to perform that action'
      redirect_to home_index_path
    end
  end

  def require_same_user
    if current_user[:id] != @group.created_by
      flash[:danger] = 'You can only edit or delete your own article'
      redirect_to groups_path
    end
  end
end
