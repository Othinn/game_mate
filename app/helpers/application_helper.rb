module ApplicationHelper

  def in_group
    UserGroup.where("user_id = ?", current_user).exists? and user_signed_in?
  end

  def count_users
    User.count
  end

  def last_sign_up
    User.last.username
  end

  def group_count
    Group.count
  end

  def anncouncement_count
    Announcement.all.count
  end


end
