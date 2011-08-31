class PoolUsersController < ApplicationController
  def create
    @pool_user = current_user.pool_users.build(params[:pool_user])
    @pool = Pool.find(params[:pool_user][:pool_id])
    @pool_user.pool_id = @pool.id

    respond_to do |format|
      if @pool_user.save
        format.html { redirect_to pool_path(@pool_user.pool), notice: 'Successfully joined pool.' }
      else
        format.html { render :template => "pools/show", :locals => { :id => @pool, :pool_user => @pool_user } }
      end
    end
  end
end
