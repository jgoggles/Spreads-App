require 'csv'

desc "Prepare database for 2021 NFL season."
task :setup_2021 => :environment do
  ActiveRecord::Base.transaction do
    NFL_SCHEDULE = 'db/NFL_2021_schedule.csv'

    puts 'Preparing database for 2021 NFL season...'

    ## Years
    puts 'Creating Year 2021 and setting to current...'
    year = Year.create!(name: '2021', current: true)
    if Year.count > 1
      Year.find_by(name: '2019').update!(current: false)
    end

    ## Weeks
    puts 'Creating weeks...'
    time = Chronic.parse("Sept 7, 2021 at 12am") #tues
    w = 0
    18.times do
      Week.create!(name: w += 1, start_date: time, end_date: time + 1.week - 1.second, year_id: year.id)
      time += 1.week
    end

    Team.find_by(nickname: "Raiders").update!(city: "Las Vegas", full_name: "Las Vegas Raiders")
    Team.find_by(nickname: "Redskins").update!(nickname: nil, full_name: "Washington Football Team")

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


desc "Prepare database for 2021 NFL season."
task :sync_espn_team_data => :environment do
  ActiveRecord::Base.transaction do
    raw_team_data = JSON.load(URI.open('https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams?limit=32'))
    
    espn_teams = raw_team_data["sports"].first["leagues"].first["teams"].map { _1["team"] }

    espn_teams.each do |espn_team|
      puts espn_team["displayName"]
      team = Team.where(city: espn_team["location"])

      if team.one?
        update_team(team.first, espn_team)
      elsif espn_team["location"] == "New York"
        if espn_team["name"] == "Jets"
          jets = team.find { _1.conference.name == "AFC"}
          update_team(jets, espn_team)
        else
          giants = team.find { _1.conference.name == "NFC"}
          update_team(giants, espn_team)
        end
      elsif espn_team["location"] == "Los Angeles"
        if espn_team["name"] == "Chargers"
          chargers = team.find { _1.conference.name == "AFC"}
          update_team(chargers, espn_team)
        else
          rams = team.find { _1.conference.name == "NFC"}
          update_team(rams, espn_team)
        end
      else
        raise "what the fuck"
      end
    end
  end
end

def update_team(team, espn_team)
  team.update!(
    nickname: espn_team["name"], 
    abbr: espn_team["abbreviation"],
    full_name: espn_team["displayName"],
    logo: espn_team["logos"].first["href"]
  )
end
