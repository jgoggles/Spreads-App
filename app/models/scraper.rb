require 'open-uri'
require 'nokogiri'

class Scraper

  class << self
    def parse_nfl_lines
      url = 'https://www.sportsinteraction.com/football/nfl-betting-lines/'

      doc = Nokogiri::HTML(open(url))

      rows = doc.css('div.game')
      lines = []
      rows.each do |a|
        line_node = a.css('div.gameBettingContent a.gameLink div.betTypeContent')[0].css('ul.runnerListColumn li')[1].at_css('span')

        matchup = a.at_css('span.title').content.match(/(.*)\s(at|v)\s(.*)/)
        away = $1.strip!
        home = $3.strip!

        [home, away].each { |t| t.gsub!("NY", "New York") }
        [home, away].each { |t| t.gsub!("Buccanneers", "Buccaneers") }

        if line_node["class"].split.include?("closed")
          line = :off
        elsif line_node.at_css('span')["class"].strip == "handicap"
          line = line_node.at_css('span.handicap').content.strip
        elsif line_node.at_css('span')["class"] == "price wide"
          line = '0.0'
        end

        game_data = {game: {}}
        game_data[:game][:home] = home
        game_data[:game][:away] = away
        game_data[:game][:over_under] = nil
        game_data[:game][:line] = line
        lines.push(game_data)
      end

      REDIS.set("#{Rails.env}_lines", lines.to_json)
      lines
    end

    def parse_nfl_scores(week = Week.current)
      url = "http://www.nfl.com/liveupdate/scores/scores.json"

      data = JSON.load(open(url))

      data.each do |k, v|
        parsed_home_team = v["home"]["abbr"]
        home_score = v["home"]["score"]["T"]
        parsed_away_team = v["away"]["abbr"]
        away_score = v["away"]["score"]["T"]
        puts "#{parsed_away_team} #{away_score} - #{parsed_home_team} #{home_score}"

        home_team = Team.find_by(abbr: parsed_home_team).games.where("week_id = ?", week.id).first.home
        home_team.score = home_score
        home_team.save

        away_team = Team.find_by(abbr: parsed_away_team).games.where("week_id = ?", week.id).first.away
        away_team.score = away_score
        away_team.save
      end
    end
  end
end
