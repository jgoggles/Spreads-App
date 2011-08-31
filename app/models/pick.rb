class Pick < ActiveRecord::Base
  belongs_to :pick_set
  belongs_to :game
  belongs_to :team

  def generate_result
    unless game_id == 0
      # if game.has_scores and game.has_started
      if game.has_scores
        if is_home?
          determine_winner((game.home.score + spread), game.away.score)
        else
          determine_winner((game.away.score + spread), game.home.score)
        end
      end
    end
  end

  def determine_winner(pick_score, non_pick_score)
    if pick_score > non_pick_score
      result = 1
    elsif pick_score < non_pick_score
      result = -1
    elsif pick_score == non_pick_score
      result = 0
    end
    self.result = result
    save
  end

  def generate_over_under_result
    unless self.game_id == 0 || self.over_under.nil?
      game = Game.find(self.game_id)
      # if game.has_scores and game.has_started
      if game.has_scores
        over = self.over_under < game.home.score + game.away.score
        even = self.over_under == game.home.score + game.away.score
        if self.is_over? && over || !self.is_over? && !over
          result = 1
        elsif even
          result = 0
        else
          result = -1
        end
        self.over_under_result = result
        save
      end
    end
  end

  def is_home?
    GameDetail.where("game_id = ?", game_id).where("team_id = ?", team_id).first.is_home?
  end

  def complete?
    !self.spread.nil? && !self.over_under.nil?
  end

end
