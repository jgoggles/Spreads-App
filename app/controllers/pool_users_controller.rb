class PoolUsersController < ApplicationController
  def create
    @pool_user = current_user.pool_users.build(pool_user_params)
    @pool = Pool.find(params[:pool_user][:pool_id])
    @pool_user.pool_id = @pool.id
    @pool_user.password = params[:pool_user][:password]

    respond_to do |format|
      if @pool_user.save
        format.html { redirect_to pool_path(@pool_user.pool), notice: 'Successfully joined pool.' }
      else
        format.html { render :template => "pools/show", :locals => { :id => @pool, :pool_user => @pool_user } }
      end
    end
  end

  private

  def pool_user_params
    params.require(:pool_user).permit(:password, :pool_id)
  end
end
