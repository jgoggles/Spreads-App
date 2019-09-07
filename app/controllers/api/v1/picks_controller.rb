class Api::V1::PicksController < Api::BaseController
  def index
    @pool = Pool.find_by(hashed_id: params[:pool])
    @user = User.find_by(hashed_id: params[:user])
    if @week.is_week_one?
      @standings = []
    else
      @standings = JSON.parse(REDIS.get("season_standings_#{@pool.id}_#{Rails.env}")).sort_by { |i| -i['points'] }
    end
    @pick_sets = @pool.pick_sets.where(week: Week.current)
    @pick_sets = @pick_sets.map do |pick_set| 
      standing = @standings.select { |s| s["player"]["id"] == pick_set.user_id } 
      if @week.is_week_one?
        pick_set.points = 0
      else
        pick_set.points = standing.first["points"]
      end
      pick_set
    end
  end
end

