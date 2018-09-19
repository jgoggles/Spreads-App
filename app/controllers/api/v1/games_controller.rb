class Api::V1::GamesController < Api::BaseController
  def index
    @games = Game.where(week: Week.current)
  end
end
