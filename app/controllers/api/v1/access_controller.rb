class Api::V1::AccessController < Api::BaseController
  def picks_available
    @pool = Pool.find_by(hashed_id: params[:pool])
    if Rails.env == "production"
      show = (Week.current.pick_cutoff_passed? || @pool.all_picks_in) && !@pool.preseason?
    else
      show = true
    end
    render json: {show_picks: show}
  end
end

