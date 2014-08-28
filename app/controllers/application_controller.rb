class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_current_week

  rescue_from CanCan::AccessDenied, :with => :not_found

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def load_current_week
    @week = Week.current
  end

end
