module Badging
  @queue = :badging

  def self.perform(pick_id)
    pick = Pick.find(pick_id)
    check_for_drunk_driver(pick)
  end

  def check_for_drunk_driver(pick)
    badge = Badge.find_by_name("Drunk Driver")
    b = Team.find_by_nickname("Bengals")
    if pick.game.teams.include?(b)
      EarnedBadge.create!(
        badge_id: badge.id,
        user_id: pick.pick_set.user.id,
        pool_id: pick.pick_set.pool.id,
        week_id: pick.pick_set.week.id,
        pick_set_id: pick.pick_set.id,
        pick_id: pick.id
      )
    end
  end
end

