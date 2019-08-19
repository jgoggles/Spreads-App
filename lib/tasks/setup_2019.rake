require 'csv'

desc "Prepare database for 2019 NFL season."
task :setup_2019 => :environment do
  NFL_SCHEDULE = 'db/NFL_2019_schedule.csv'

  puts 'Preparing database for 2019 NFL season...'

  ## Years
  puts 'Creating Year 2019 and setting to current...'
  year = Year.create(name: '2019', current: true)
  if Year.count > 1
    Year.previous.update(current: false)
  end

  ## Weeks
  puts 'Creating weeks...'
  time = Chronic.parse("Sept 3, 2019") - 12.hours
  w = 0
  17.times do
    Week.create!(:name => w += 1, :start_date => time, :end_date => time + 1.week - 1.second, year_id: year.id)
    time += 1.week
  end

  ### Games
  CSV.foreach(NFL_SCHEDULE, {:headers=>:first_row}) do |row|
    puts "Home: #{row[6].strip}"
    home = Team.all.find { |team| team.full_name == row[6].strip }
    puts "Away: #{row[3].strip}"
    away = Team.all.find { |team| team.full_name == row[3].strip }
    date = Chronic.parse("#{row[2]} #{row[8]}") - 2.hours
    puts date
    week = Week.where(name: row[0], year_id: year.id).first
    week_id = week.id
    game = Game.create!(:week_id => week_id, :date => date)
    GameDetail.create!(:game_id => game.id, :team_id => home.id, :is_home => true)
    GameDetail.create!(:game_id => game.id, :team_id => away.id, :is_home => false)
  end
end

