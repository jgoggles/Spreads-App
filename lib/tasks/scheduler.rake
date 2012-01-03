desc "Grabs lines"
task :update_nfl_lines => :environment do
  puts "Updating lines..."
  Scraper.parse_nfl_lines
  puts "done."
end

desc "Gets scores and generates standings and badges"
task :update_standings => :environment do
  if Time.now.monday?
    puts "Parsing scores.."
    Scraper.parse_nfl_scores
    puts "Generating standings and badges..."
    StandingGenerator.generate_standings
  end

  if Time.now.tuesday?
    puts "Parsing scores.."
    Scraper.parse_nfl_scores(Week.previous)
    puts "Generating standings and badges..."
    StandingGenerator.generate_standings(process_non_picks = true)
  end
end
