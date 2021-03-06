require 'csv'
require 'chronic'
require 'nfl'

NFL_SCHEDULE = 'db/NFL_2012_Complete.csv'

############
# all envs #
############
## Pool Types
#PoolType.connection.execute("TRUNCATE pool_types")
#PoolType.create!(name: "Kamikaze", max_picks: nil, min_picks: 3, spreads: true, over_under: false, is_tiebreaker: false)
#PoolType.create!(name: "3 Pick Standard", max_picks: 3, min_picks: 3, spreads: true, over_under: false, is_tiebreaker: false)

## Leagues
#League.connection.execute("TRUNCATE leagues")
#League.create!(:name => NFL[:name], :sport => NFL[:sport])

## ## Conferences
#Conference.connection.execute("TRUNCATE conferences")
#NFL[:conferences].each { |c| Conference.create!(:name => c[:name], :league_id => League.find_by_name(NFL[:name]).id) }

## ## Divisions
#Division.connection.execute("TRUNCATE divisions")
#NFL[:conferences].each do |c|
  #c[:divisions].each do |d|
    #Division.create!(:name => d[:name]) unless !Division.find_by_name(d[:name]).nil?
  #end
#end

## ## Teams
#Team.connection.execute("TRUNCATE teams")
#NFL[:conferences].each do |c|
  #c[:divisions].each do |d|
    #d[:teams].each do |t|
      #Team.create!(:city => t[:city], :nickname => t[:nickname],
                   #:league_id => League.find_by_name(NFL[:name]),
                   #:conference_id => Conference.find_by_name(c[:name]).id,
                   #:division_id => Division.find_by_name(d[:name]).id)
    #end
  #end
#end

### Games
#Game.connection.execute("TRUNCATE games")
#Game.connection.execute("TRUNCATE game_details")
#CSV.foreach(NFL_SCHEDULE, {:headers=>:first_row}) do |row|
  #puts row[16].strip
  #home = Team.find_by_nickname(row[16].strip)
  #puts row[15].strip
  #away = Team.find_by_nickname(row[15].strip)
  #date = Chronic.parse("#{row[0]} #{row[5]}")
  #week = Week.where("start_date <= ?", date).where("end_date >= ?", date).first
  #week_id = week.id
  #game = Game.create!(:week_id => week_id, :date => date)
  #GameDetail.create!(:game_id => game.id, :team_id => home.id, :is_home => true)
  #GameDetail.create!(:game_id => game.id, :team_id => away.id, :is_home => false)
#end


### Roles
#Role.connection.execute("TRUNCATE roles")
#%w{Admin Member PoolAdmin}.each { |r| Role.create(name: r) }

## ## Badges
#Badge.connection.execute("TRUNCATE badges")
#Badge.create!(name: "Drunk Driver", desc: "Picking a game in which the Cincinnati Bengals are involved.", image: "drunk_driver")
#Badge.create!(name: "Homer", desc: "Picking your favorite team.", image: "homer")
#Badge.create!(name: "Toxic", desc: "Picking against your favorite team.", image: "traitor")
#Badge.create!(name: "Skin of Your Teeth", desc: "Winning by less than 3 point ATS.", image: "skin_of_your_teeth")
#Badge.create!(name: "Tough Luck", desc: "Losing by less than 3 points ATS", image: "tough_luck")
#Badge.create!(name: "Pusher", desc: "Pushing is hard.", image: "pusher")


###############
# development #
###############

#if Rails.env == "development"
#  ## Games
#  games = Game.where('week_id = 18')
#  games.each {|g| g.update_attributes(:home_score => rand(42), :away_score => rand(42))}
#
#  ## Weeks
#  Week.create!(:name => 'Test', :start_date => Time.now - 5.years, :end_date => Time.now - 5.years + 1.week)
#
#  ## Users
#  User.connection.execute("TRUNCATE users")
#  i = 0
#  4.times do 
#    User.create!(:email => "test_guy#{i += 1}@test.com", :password => "password", :password_confirmation => "password")
#  end
#
#  ## PickSets
#  PickSet.connection.execute("TRUNCATE pick_sets")
#  users = User.all
#  users.each do |u|
#    PickSet.create!(:user_id => u.id, :week_id => Week.all.size)
#  end
#
#  # Picks
#  Pick.connection.execute("TRUNCATE picks")
#  users = User.all
#  i = -7.0; set = []; 28.times {set.push(i += 0.5)};
#  pick_set_id = 0
#  users.each do |u|
#    game_id = 0
#    pick_set_id += 1
#    3.times do
#      Pick.create!(:spread => set[rand(set.size - 1)], :game_id => game_id +=1, :pick_set_id => pick_set_id, :is_home => rand(2))
#    end
#  end
#end
