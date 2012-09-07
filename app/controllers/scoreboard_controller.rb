class ScoreboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_current_week
  load_and_authorize_resource :pool
  load_and_authorize_resource :pick_set, :through => :pool, :except => [:show, :edit, :update]

  def live
    @pick_set = current_user.pick_set_for_this_week(@pool) 
  end

end
