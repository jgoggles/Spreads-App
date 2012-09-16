require Rails.root + "app/models/scoreboard_scraper"

namespace :scoreboard do
  
  desc "Grab all NFL Scores and send them to Pusher"
  task :get_scores => :environment do
    print "Getting Scores..."
    Pool.where(year_id: Year.current.id).each do |pool|
      sbs = ScoreboardScraper.new
      sbs.get_scores pool
    end
    puts "Done."
  end

end

