class StandingGenerator
  @queue = :standings_queue

  class << self

    def perform(method)
      with_logging method do
        self.new.send(method)
      end

    end

    def with_logging(method, &block)
      log("starting...", method)

      time = Benchmark.ms do
        yield block
      end

      log("completed in (%.1fms)" % [time], method)
    end

    def log(message, method = nil)
      now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      puts "#{now} %s#%s - #{message}" % [self.name, method]
    end

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
    Resque.redis.set("season_standings_#{pool.id}", standings.to_json)
   end

  end

end
