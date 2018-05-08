class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :in_group
  helper_method :users_groups
  helper_method :count_users

  def users_groups
    @users_groups = Group.user_in_any_group?(current_user)
  end

  def in_group
    UserGroup.where("user_id = ?", current_user).exists? and user_signed_in?
  end

  def count_users
    User.count
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
  end

end
