class Api::V1::PicksController < Api::BaseController
  def index
    #@pool_id = params[:pool_id]
    @pool_id = 15
    @standings = JSON.parse(REDIS.get("season_standings_#{@pool_id}_#{Rails.env}")).sort_by { |i| -i['points'] }
    @pick_sets = PickSet.where(week: Week.current)
    @pick_sets = @pick_sets.map do |pick_set| 
      standing = @standings.select { |s| s["player"]["id"] == pick_set.user_id } 
      pick_set.points = standing.first["points"]
      pick_set
    end
  end
end

