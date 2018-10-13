class Api::V1::StatsController < Api::BaseController
  def index
    @pool = Pool.find_by(hashed_id: params[:pool])
    @pick_sets = @pool.pick_sets.where(week: Week.current)
    @home_vs_away = PickSet.home_vs_away(@pick_sets)
    @favorite_vs_underdog = PickSet.favorite_vs_underdog(@pick_sets)
    @most_action = PickSet.most_action(@pick_sets)
    @most_picked = PickSet.most_picked(@pick_sets)
  end
end

