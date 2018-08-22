class Api::V1::GamesController < Api::BaseController
  def index
    #@games = Game.where(week: Week.current)
    @games = Game.where(week: Week.previous)
  end
end
