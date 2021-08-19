require 'open-uri'
require 'nokogiri'

class Scraper
  def self.parse_nfl_scores(week = Week.current)
    url = "http://www.nfl.com/liveupdate/scores/scores.json"

    data = JSON.load(open(url))

    data.each do |k, v|
      v["home"]["abbr"].gsub!(/LA$/, "LAR")
      parsed_home_team = v["home"]["abbr"]
      home_score = v["home"]["score"]["T"]
      parsed_away_team = v["away"]["abbr"]
      v["away"]["abbr"].gsub!(/LA$/, "LAR")
      away_score = v["away"]["score"]["T"]
      puts "#{parsed_away_team} #{away_score} - #{parsed_home_team} #{home_score}"

      home_team = Team.find_by(abbr: parsed_home_team).games.where(week_id: week.id).first.home
      home_team.score = home_score
      home_team.save

      away_team = Team.find_by(abbr: parsed_away_team).games.where(week_id: week.id).first.away
      away_team.score = away_score
      away_team.save
    end
  end
end
