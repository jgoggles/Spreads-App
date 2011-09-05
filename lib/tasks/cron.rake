desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts "Updating lines..."
  Scraper.parse_nfl_lines
  puts "done."
end

