class StandingGenerator

  def initialize(method)
    @method = method
  end

  def perform
    self.send(@method)
  end

  def generate_standings
    User.all.each do |user|
      user.pools.each do |pool|
        user.process_non_picks(pool)
      end
    end

    Pool.all.each do |pool|
      Standing.generate(pool.pick_sets)
      standings = Standing.for_season(pool.users, pool)
      REDIS.set("season_standings_#{pool.id}", standings.to_json)
    end

  end

end