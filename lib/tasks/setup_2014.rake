desc "Prepare database for 2014 NFL season."
task :setup_2014 => :environment do
  NFL_SCHEDULE = 'db/NFL_2014_Complete.csv'

  puts 'Preparing database for 2014 NFL season...'

  ## Years
  puts 'Creating Year 2014 and setting to current...'
  Year.find_or_create_by_name(name: '2014', current: true)
  Year.previous.update_attribute(:current, false) if Year.count > 1

  ## Weeks
  puts 'Creating weeks...'
  t = Chronic.parse("Sept 2, 2014") - 12.hours
  w = 0
  17.times do
    Week.create!(:name => w += 1, :start_date => t, :end_date => t + 1.week - 1.second, year_id: Year.last.id)
    t += 1.week
  end

  ## Games
  CSV.foreach(NFL_SCHEDULE, {:headers=>:first_row}) do |row|
    puts row[5].strip
    home = Team.all.find { |t| t.full_name == row[5].strip }
    puts row[3].strip
    away = Team.all.find { |t| t.full_name == row[3].strip }
    date = Chronic.parse("#{row[2]} #{row[6]}")
    week = Week.where(name: row[0], year_id: Year.current.id).first
    week_id = week.id
    game = Game.create!(:week_id => week_id, :date => date)
    GameDetail.create!(:game_id => game.id, :team_id => home.id, :is_home => true)
    GameDetail.create!(:game_id => game.id, :team_id => away.id, :is_home => false)
  end
end
