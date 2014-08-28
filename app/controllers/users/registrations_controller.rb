class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new params[:user]
    super
  end

  private
  def build_resource(*args)
    super
  end
end
