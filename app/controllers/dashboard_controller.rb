class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @pools = current_user.pools
  end

end
