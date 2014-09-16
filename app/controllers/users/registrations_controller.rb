class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def create
    @user = User.new params[:user]
    super
  end

  private
  def build_resource(*args)
    super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :favorite_nfl_team_id) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :favorite_nfl_team_id) }
  end
  
end
