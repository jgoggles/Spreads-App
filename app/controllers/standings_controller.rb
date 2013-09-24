class StandingsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :load_current_week
  before_filter :get_pool
  before_filter :check_pick_total

  def index
    unless Week.current.is_week_one_or_offseason? && !@pool.over?
      #@standings = JSON.parse(REDIS.get("season_standings_#{@pool.id}_production")).sort_by { |i| -i['points'] }
      @standings = JSON.parse(REDIS.get("season_standings_#{@pool.id}_#{Rails.env}")).sort_by { |i| -i['points'] }
    end
    @pick_sets = current_user.pick_sets.where('pool_id = ?', @pool.id).order("created_at ASC")
  end

  def show
    unless @pool.over?
      #if (params[:week_id].to_i > Week.current.name.to_i) || ((!@week.pick_cutoff_passed? || !@pool.all_picks_in) && params[:week_id].to_i == Week.current.name.to_i)
      if params[:week_id].to_i > Week.current.name.to_i
        raise ActionController::RoutingError.new('Not Found')
      end

      if !@pool.all_picks_in && !@week.pick_cutoff_passed? && (params[:week_id].to_i == Week.current.name.to_i)
        raise ActionController::RoutingError.new('Not Found')
      end
    end
    @week = @pool.year.weeks.find_by_name(params[:week_id])
    @pick_sets = @pool.pick_sets.where("week_id = ?", @week.id).sort_by { |ps| ps.user.display_name }
    @home_vs_away = PickSet.home_vs_away(@pick_sets)
    @favorite_vs_underdog = PickSet.favorite_vs_underdog(@pick_sets)
    @most_action = PickSet.most_action(@pick_sets)
    @most_picked = PickSet.most_picked(@pick_sets)
    @team_breakdown = PickSet.team_breakdown(@pick_sets)
  end

  private
  def get_pool
    @pool = Pool.find(params[:pool_id])
  end

  def check_pick_total
    #if @pool.all_picks_in && @pool.year == Year.current
    if (@pool.all_picks_in || @week.pick_cutoff_passed?) && @pool.year == Year.current
      @week_list = Week.current
    elsif @pool.over?
      @week_list = @pool.year.weeks.last
    else
      unless Week.current.is_week_one?
        @week_list = Week.previous
      end
    end
  end

end
