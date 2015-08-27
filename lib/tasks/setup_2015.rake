desc "Prepare database for 2015 NFL season."
task :setup_2015 => :environment do
  NFL_SCHEDULE = 'db/NFL_2015_Complete.csv'

  puts 'Preparing database for 2015 NFL season...'

  ## Years
  puts 'Creating Year 2015 and setting to current...'
  year = Year.create(name: '2015', current: true)
  Year.previous.update(current: false) if Year.count > 1

  ## Weeks
  puts 'Creating weeks...'
  time = Chronic.parse("Sept 7, 2015") - 12.hours
  w = 0
  17.times do
    Week.create!(:name => w += 1, :start_date => time, :end_date => time + 1.week - 1.second, year_id: year.id)
    time += 1.week
  end

  ### Games
  CSV.foreach(NFL_SCHEDULE, {:headers=>:first_row}) do |row|
    puts row[5].strip
    home = Team.all.find { |team| team.full_name == row[5].strip }
    puts row[3].strip
    away = Team.all.find { |team| team.full_name == row[3].strip }
    date = Chronic.parse("#{row[2]} #{row[6]}")
    week = Week.where(name: row[0], year_id: year.id).first
    week_id = week.id
    game = Game.create!(:week_id => week_id, :date => date)
    GameDetail.create!(:game_id => game.id, :team_id => home.id, :is_home => true)
    GameDetail.create!(:game_id => game.id, :team_id => away.id, :is_home => false)
  end
end
