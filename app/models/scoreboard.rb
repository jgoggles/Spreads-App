class Scoreboard
  def initialize(week = Week.current)
    @week = week
  end

  def games
    games = Game.where(week: @week)
    formatted_games(games)
  end

  private

  def formatted_games(games)
    games.map do |game|
      { id: game.id, away: game.away.team, home: game.home.team }
    end
  end
end
