desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts "Updating lines..."
  Scraper.parse_nfl_lines
  puts "done."

  if Time.now.monday? and Time.now.hour == 3
    puts "Generating standings and badges..."
    StandingGenerator.generate_standings
  end

  if Time.now.tuesday? and Time.now.hour == 3
    puts "Generating standings and badges..."
    StandingGenerator.generate_standings(process_non_picks = true)
  end
end

