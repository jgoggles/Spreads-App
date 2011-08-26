class DashboardController < ApplicationController
  def index
    if current_user
      @pools = current_user.pools
    end
  end

end
