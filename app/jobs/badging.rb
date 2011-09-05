class Badging
  @queue = :badging

  class <<  self
    def perform(klass, record_id)
      record = Kernel.const_get(klass.to_s.capitalize).find(record_id)
      self.instance_methods(false).grep(/#{klass}_check*/).each { |m| self.new.send(m, record) }
    end

    def create_for_pick(badge, pick)
      EarnedBadge.create!(
        badge_id: badge.id,
        user_id: pick.pick_set.user.id,
        pool_id: pick.pick_set.pool.id,
        week_id: pick.pick_set.week.id,
        pick_set_id: pick.pick_set.id,
        pick_id: pick.id
      )
    end

    def create_for_pick_set(badge, pick_set)
      EarnedBadge.create!(
        badge_id: badge.id,
        user_id: pick_set.user.id,
        pool_id: pick_set.pool.id,
        week_id: pick_set.week.id,
        pick_set_id: pick_set.id
      )
    end
  end

  def pick_check_for_drunk_driver(pick)
    badge = Badge.find_by_name("Drunk Driver")
    b = Team.find_by_nickname("Bengals")
    if pick.game.teams.include?(b)
      Badging.create_for_pick(badge, pick)
    end
  end

  def pick_check_for_homer(pick)
    badge = Badge.find_by_name("Homer")
    unless pick.pick_set.user.favorite_nfl_team_id.nil?
      fav = Team.find(pick.pick_set.user.favorite_nfl_team_id)
      if pick.team == fav
        Badging.create_for_pick(badge, pick)
      end
    end
  end

  def pick_check_for_toxic(pick)
    badge = Badge.find_by_name("Toxic")
    unless pick.pick_set.user.favorite_nfl_team_id.nil?
      fav = Team.find(pick.pick_set.user.favorite_nfl_team_id)
      if pick.opponent == fav
        Badging.create_for_pick(badge, pick)
      end
    end
  end

  def pick_check_for_tough_luck(pick)
    badge = Badge.find_by_name("Tough Luck")
    team_picked = pick.is_home? ? pick.game.home : pick.game.away
    pick_opp = pick.is_home? ? pick.game.away : pick.game.home
    if !pick.result.nil? and pick.result == 1
      if pick.game.has_scores
        diff = (team_picked.score + pick.spread) - pick_opp.score
        if diff > -3 and diff < 0
          Badging.create_for_pick(badge, pick)
        end
      end
    end
  end

  def pick_check_for_skin_of_your_teeth(pick)
    badge = Badge.find_by_name("Skin of Your Teeth")
    team_picked = pick.is_home? ? pick.game.home : pick.game.away
    pick_opp = pick.is_home? ? pick.game.away : pick.game.home
    if !pick.result.nil? and pick.result == 1
      if pick.game.has_scores
        diff = (team_picked.score + pick.spread) - pick_opp.score
        if diff < 3 and diff > 0
          Badging.create_for_pick(badge, pick)
        end
      end
    end
  end

  def pick_check_for_pusher(pick)
    badge = Badge.find_by_name("Pusher")
    if !pick.result.nil? and pick.result == 0
      Badging.create_for_pick(badge, pick)
    end
  end
end
