class Pools::PlayersController < ApplicationController
  before_filter :load_pool
  def index
    authorize! :update, @pool
  end

  def update_pool_users
    authorize! :update, @pool
    params[:pool_user].each do |k,v|
      p = PoolUser.find(k)
      p.paid = v[:paid]
      p.pool_admin = v[:pool_admin]
      p.save
    end
    flash[:notice] = 'Players were successfully updated.'
    redirect_to :action => "index"
  end

  private
  def load_pool
    @pool = Pool.find(params[:pool_id])
  end


end
