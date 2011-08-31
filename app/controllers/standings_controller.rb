class StandingsController < ApplicationController
  load_and_authorize_resource

  before_filter :get_pool

  def index
    @standings = @pool.standings
  end

  def show
    @week = params[:week_id]
  end

  private
  def get_pool
    @pool = Pool.find(params[:pool_id])
  end
end
