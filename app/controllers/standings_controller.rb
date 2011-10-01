class StandingsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :get_pool
  before_filter :check_pick_total

  def index
    unless Week.current.name == "1"
      @standings = JSON.parse(REDIS.get("season_standings_#{@pool.id}_#{Rails.env}")).sort_by {|i| -i['points']}
    end
    @pick_sets = current_user.pick_sets.where('pool_id = ?', @pool.id).order("created_at ASC")
  end

  def show
    if (params[:week_id].to_i > Week.current.name.to_i) or (!@pool.all_picks_in and params[:week_id].to_i == Week.current.name.to_i)
      raise ActionController::RoutingError.new('Not Found')
    else
      @week = Week.find_by_name(params[:week_id])
      @pick_sets = @pool.pick_sets.where("week_id = ?", @week.id).sort_by { |ps| ps.user.display_name }
      @home_vs_away = PickSet.home_vs_away(@pick_sets)
      @favorite_vs_underdog = PickSet.favorite_vs_underdog(@pick_sets)
      @most_action = PickSet.most_action(@pick_sets)
      @most_picked = PickSet.most_picked(@pick_sets)
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
      unless Week.current.name == "1"
        @week_list = Week.previous
      end
    end
  end

end
