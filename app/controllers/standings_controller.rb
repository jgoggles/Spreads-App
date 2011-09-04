class StandingsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :get_pool
  before_filter :check_pick_total

  def index
    @standings = JSON.parse(Resque.redis.get("season_standings_#{@pool.id}"))
    @pick_sets = current_user.pick_sets.where('pool_id = ?', @pool.id)
  end

  def show
    if params[:week_id].to_i > Week.current.id or !@pool.all_picks_in
      raise ActionController::RoutingError.new('Not Found')
    else
      @week = Week.find(params[:week_id])
      @pick_sets = @pool.pick_sets.where("week_id = ?", @week.id)
    end
  end

  private
  def get_pool
    @pool = Pool.find(params[:pool_id])
  end

  def check_pick_total
    if @pool.all_picks_in
      @week_list = Week.current
    else
      @week_list = Week.previous
    end
  end

end
