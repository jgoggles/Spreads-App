desc "Grabs lines"
task :update_nfl_lines => :environment do
  puts "Updating lines..."
  Scraper.parse_nfl_lines
  puts "done."
end

desc "Gets scores and generates standings and badges"
task :update_standings => :environment do
  #if Time.now.monday?
    #puts "Parsing scores.."
    #Scraper.parse_nfl_scores
    #puts "Generating standings and badges..."
    #StandingGenerator.generate_standings
  #end

  if Time.now.tuesday?
    puts "Parsing scores.."
    Scraper.parse_nfl_scores(Week.previous)
    puts "Generating standings and badges..."
    StandingGenerator.generate_standings(process_non_picks = true)
  end
end

desc "Remind users to make picks"
task :remind_users => :environment do
  if Time.now.friday?
    week = Week.current
    Pool.current.each do |pool|
      pool.users.each do |user|
        if user.can_make_picks?(week, pool)
          UserMailer.pick_reminder(user, pool).deliver
        end
      end
    end 
  end
end
