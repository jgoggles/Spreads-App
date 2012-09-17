require 'open-uri'
require 'pusher'

# TODO: move into config
if Rails.env == 'production'
  Pusher.app_id = '27802'
  Pusher.key    = '90571ae84cb59a530519'
  Pusher.secret = 'bf21c9e9c54744ad0e50'
else
  Pusher.app_id = '27253'
  Pusher.key    = '9919c79f1a6d362b15ee'
  Pusher.secret = '33cd2f68ed4b0cfb65db'
end

class ScoreboardScraper
  attr_accessor :scores, :data

  def initialize
    @scores = {} 
    @data = {}
    @data[:live_scores] = {}
    @data[:live_standings] = []
  end

  def get_scores(pool)
    json = retrieve_scores
    build_scores_data json
    send_pick_data pool
    send_standings_data pool
  end

  def retrieve_scores
    url = "http://www.nfl.com/liveupdate/scorestrip/scorestrip.json"
    json_response = open(url).read
    
    # Clean up the JSON, NFL returns invalid JSON with ,, in it
    while json_response.include?(",,")
      json_response = json_response.gsub(',,',',"",')
    end
    json = JSON.parse(json_response)
    json
  end

  private

  def build_scores_data(json)
    json["ss"].each do |game_json|
      away_team = game_json[4]
      game = GameDetail.joins([:team, :game]).where("teams.abbr" => away_team, "games.week_id" => Week.current.id).first.game
      @scores[game.id] = build_game_hash(game, game_json)
    end
  end

  def build_game_hash(game, game_json)
    away_team = game_json[4]
    home_team = game_json[6]
    quarter = game_json[2]
    quarter = game_json[0] if quarter == "Pregame"
    time_remaining = game_json[3]
    time_remaining = game_json[1] if game_json[2] == "Pregame"
    game_hash = {
      "game_id" => game.id,
      away_team => game_json[5],
      home_team => game_json[7],
      "quarter" => quarter,
      "time_remaining" => time_remaining
    }
    game_hash
  end

  def send_pick_data(pool)
    # Build the live scores
    pick_sets = pool.pick_sets.where(week_id: Week.current.id)
    pick_sets.each do |ps|
      pick_set_data = []
      ps.picks.each do |pick|
        pick_score = @scores[pick.game.id][pick.team.abbr].to_i rescue nil
        opp_score = @scores[pick.game.id][pick.opponent.abbr].to_i rescue nil 
        adjusted_score = (pick_score.nil?) ? (spread * -1) : opp_score + (pick.spread * -1)
        live_score = {
          "user_id" => ps.user_id,
          "spread" => pick.spread * -1,
          "quarter" => @scores[pick.game.id]["quarter"],
          "time_remaining" => @scores[pick.game.id]["time_remaining"],
          "team" => {
            "nickname" => pick.team.nickname.downcase,
            "abbr" => pick.team.abbr,
            "score" => pick_score
          },
          "opponent" => {
            "nickname" => pick.opponent.nickname.downcase,
            "abbr" => pick.opponent.abbr,
            "score" => opp_score,
            "adjusted_score" => adjusted_score
          },
          "result" => result_string(pick_score, adjusted_score, @scores[pick.game.id]['quarter'])
        }
        pick_set_data << live_score
        @data[:live_scores][pick.id] = live_score
      end
      Pusher['scores'].trigger('pick-set-update', pick_set_data.to_json)
    end
  end

  def send_standings_data(pool)
    current = JSON.parse(REDIS.get("season_standings_#{pool.id}_#{Rails.env}")).sort_by { |i| -i['points'] }
    live_standings = []
    current.each do |s|
      user = User.find s['player']['id']
      pick_set = user.pick_sets.where(pool_id: pool.id, week_id: Week.current.id).first
      this_week = get_week_record(pick_set)

      standings = {
        "user_id" => user.id,
        "display_name" => user.display_name,
        "current_record" => "#{s['wins']}-#{s['losses']}-#{s['pushes']}",
        "points" => s['points'],
        "this_week" => this_week['record'],
        "this_week_points" => this_week['points'],
        "live_points" => (this_week['points'].to_i + s['points'].to_i),
        "games_remaining" => this_week['games_remaining']
      }
      live_standings << standings
    end
    # Sort the standings according to live points
    live_standings.sort! { |x,y| y['live_points'] <=> x['live_points'] }
    Pusher['scores'].trigger('standings-update', live_standings.to_json)
  end

  def result_string(pick_score, adjusted_score, quarter)
    if %w{1 2 3 4 Halftime Final}.include?(quarter) == false
      "-"
    elsif adjusted_score > pick_score
      "L"
    elsif adjusted_score == pick_score
      "P"
    else
      "W"
    end
  end

  def get_week_record(pick_set)
    wins = 0
    losses = 0
    pushes = 0
    games_remaining = 0
    result = {}

    if !pick_set.nil?
      pick_set.picks.each do |pick|
        live_score = @data[:live_scores][pick.id]
        pick_score = live_score['team']['score'].to_f
        adj_opp_score = live_score['opponent']['adjusted_score'].to_f
        if %w{1 2 3 4 Halftime Final}.include?(live_score['quarter']) == false
          games_remaining += 1
        elsif pick_score > adj_opp_score
          wins += 1
        elsif pick_score == adj_opp_score
          pushes += 1
        else
          losses += 1
        end
        result = {
          "record" => "#{wins}-#{losses}-#{pushes}",
          "points" => (wins - losses),
          "games_remaining" => games_remaining
        }
      end
    else
      result = {
        "record" => "0-0-0",
        "points" => 0,
        "games_remaining" => 3
      }
    end
    result
  end

end

