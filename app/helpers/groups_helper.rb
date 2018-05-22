module GroupsHelper

  def user_group_ids
    @user_group_ids = current_user.user_groups.pluck(:group_id)
  end
end
