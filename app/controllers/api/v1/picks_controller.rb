class Api::V1::PicksController < Api::BaseController
  def index
    @pool = Pool.find params[:pool_id]
    @standings = JSON.parse(REDIS.get("season_standings_#{@pool.id}_#{Rails.env}")).sort_by { |i| -i['points'] }
    @pick_sets = @pool.pick_sets.where(week: Week.current)
    @pick_sets = @pick_sets.map do |pick_set| 
      standing = @standings.select { |s| s["player"]["id"] == pick_set.user_id } 
      pick_set.points = standing.first["points"]
      pick_set
    end
  end
end

