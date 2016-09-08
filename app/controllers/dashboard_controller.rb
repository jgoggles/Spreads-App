class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.god?
      @pools = Pool.all
    else
      @pools = current_user.pools
    end
  end

end
