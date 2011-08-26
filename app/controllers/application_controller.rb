class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    if request.env["HTTP_REFERER"]
      redirect_to :back
    else
      redirect_to root_path
    end
  end

end
