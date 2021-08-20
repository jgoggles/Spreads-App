# frozen_string_literal: true

module Espn
  module Lines
    class Update
      include EspnIngestable

      method_object [week: Week.current]

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

      def teams(game)
        game["name"].split(" at ").map(&:strip)
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
      rescue
        nil
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
end
