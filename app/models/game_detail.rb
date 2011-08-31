class GameDetail < ActiveRecord::Base
  attr_accessible :team_id, :score, :is_home, :game_id

  belongs_to :game
  belongs_to :team
end
