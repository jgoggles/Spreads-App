require 'resque_scheduler'

ENV["REDISTOGO_URL"] ||= "redis://jgoggles:54d3fcd90cb9284b5e41a1e207481516@icefish.redistogo.com:9102/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Resque.schedule = YAML.load_file("#{Rails.root}/config/resque_scheduler.yml")

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

