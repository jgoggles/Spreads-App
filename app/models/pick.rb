class Pick < ActiveRecord::Base
  belongs_to :pick_set
  belongs_to :game
  belongs_to :team
  has_many :earned_badges

  def generate_result
    unless game_id == 0
      if game.has_scores and game.has_started
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
      if game.has_scores and game.has_started
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

  def is_non_pick?
    game_id == 0 and team_id == 0
  end

  def is_home?
    GameDetail.where("game_id = ?", game_id).where("team_id = ?", team_id).first.is_home?
  end

  def opponent
    if is_home?
      game.away.team
    else
      game.home.team
    end
  end

  def display_opponent
    is_home? ? "vs #{opponent.nickname}" : "at #{opponent.nickname}"
  end

  def complete?
    if pick_set.pool.pool_type.over_under?
      !self.spread.nil? && !self.over_under.nil?
    else
      !self.spread.nil?
    end
  end

  def result_in_words
    case result
    when 1
      "Win"
    when -1
      "Loss"
    when 0
      "Push"
    else
      ""
    end
  end

  def favorite?
    spread < 1
  end

  def underdog?
    spread > 1
  end

  def loss?
   result == -1
  end

  def win?
    result == 1
  end

  def push?
    result == 0
  end

end
