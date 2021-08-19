# frozen_string_literal: true
require 'open-uri'

module Lines
  class Update
    BASE_URL = "http://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard"
    method_object [week_name: Week.current.name]

    def call
      lines = games.map do |game|
        away, home = teams(game)
        game_data = {game: {}}
        game_data[:game][:home] = home
        game_data[:game][:away] = away
        game_data[:game][:line] = line(game, home)

        game_data
      end

      REDIS.set("#{Rails.env}_lines", lines.to_json)
    end

    private

    def url
      "#{BASE_URL}?week=#{week_name}&seasontype=1"
    end

    def games
      @_games ||= JSON.load(URI.open(url))["events"]
    end

    def teams(game)
      game["name"].split(" at ")
    end

    def line(game, home)
      raw_line = parse_line(game)

      if raw_line == "EVEN"
        "0.0"
      elsif raw_line.nil?
        :off
      else
        favorite, line = raw_line.split(" ")
        if team_abbr_map[home] == favorite
          line
        else
          "+#{line.to_i * -1}"
        end
      end
    end

    def parse_line(game)
      game["competitions"].
        first["odds"].
        first["details"]
    end

    def team_abbr_map
      @_team_abbr_map ||=
        Team.all.reduce({}) do |abbr_map, team|
          abbr_map[team.full_name] = team.abbr
          abbr_map
        end
    end
  end
end
