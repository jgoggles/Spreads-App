require 'csv'

desc "Prepare database for 2021 NFL preseason."
task :setup_2021_preseason => :environment do
  ActiveRecord::Base.transaction do
    NFL_SCHEDULE = 'db/NFL_2021_preseason_schedule.csv'

    puts 'Preparing database for 2021 NFL preseason...'

    puts 'Creating Year 2021 and setting to current...'
    Year.current.update!(current: false)
    year = Year.find_by(name: '2021 preseason')
    year ||= Year.create!(name: '2021 preseason', current: true)
    year.update!(current: true)

    ## Weeks
    puts 'Creating weeks...'
    time = Chronic.parse("Aug 3, 2021 at 12am") #tues
    w = 0
    4.times do
      Week.create!(name: w += 1, start_date: time, end_date: time + 1.week - 1.second, year_id: year.id)
      time += 1.week
    end

    Team.find_by(city: "Washington").update!(full_name: "Washington Football Team")

    ### Games
    CSV.foreach(NFL_SCHEDULE, {:headers=>:first_row}) do |row|
      puts "Home: #{row[6].strip}"
      home = Team.find_by(full_name: row[6].strip)
      puts "Away: #{row[3].strip}"
      away = Team.find_by(full_name: row[3].strip)
      date = Chronic.parse("#{row[2]} #{row[8]}") - 2.hours
      puts date
      week = Week.where(name: row[0], year_id: year.id).first
      week_id = week.id
      game = Game.create!(week_id: week_id, date: date)
      GameDetail.create!(game_id: game.id, team_id: home.id, is_home: true)
      GameDetail.create!(game_id: game.id, team_id: away.id, is_home: false)
    end

    Team.find_by(city: "Washington").update!(full_name: "Washington ")
  end
end

