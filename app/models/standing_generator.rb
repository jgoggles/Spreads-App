class StandingGenerator

  def initialize(method)
    @method = method
  end

  def perform
    self.send(@method)
  end

  class << self
    def generate_standings(process_non_picks = false)
      return if Week.current.is_week_one_or_offseason?

      if process_non_picks
        User.all.each do |user|
          user.active_pools.each do |pool|
            user.process_non_picks(pool)
          end
        end
      end

      Year.current.pools.each do |pool|
        if process_non_picks # only do these when the week is over, same as process non picks
          Delayed::Job.enqueue Badging.new(:pool, pool.id)
        end
        Standing.generate(pool.pick_sets)
        standings = Standing.for_season(pool.users, pool)
        REDIS.set("season_standings_#{pool.id}_#{Rails.env}", standings.to_json)
      end

    end
  end

end
