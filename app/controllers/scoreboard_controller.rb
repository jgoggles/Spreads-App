class ScoreboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_current_week
  load_and_authorize_resource :pool
  load_and_authorize_resource :pick_set, :through => :pool, :except => [:show, :edit, :update]

  def live
    if @pool.all_picks_in || @week.pick_cutoff_passed?
      @pick_set = current_user.pick_set_for_this_week(@pool)
      @standings = JSON.parse(REDIS.get("season_standings_#{@pool.id}_#{Rails.env}")).sort_by { |i| -i['points'] }
    else
      redirect_to @pool, notice: 'You can\'t view the live scoreboard until everyone has made their picks.'
    end
  end

end
