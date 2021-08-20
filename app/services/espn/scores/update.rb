# frozen_string_literal: true

module Espn
  module Scores
    class Update
      include EspnIngestable

      method_object [week: Week.current]

      def call
        ActiveRecord::Base.transaction do
          games.each do |game|
            scores = scores_for(game)

            scores.each do |team_abbr, game_data|
              puts "#{team_abbr} - #{game_data[:home_away]} - #{game_data[:score]}"
              game_for(team_abbr, game_data[:home_away]).update!(score: game_data[:score])
            end
          end
          nil
        end
      end

      private

      def game_for(abbr, home_away)
        Team.find_by(abbr: abbr).games.find_by(week_id: week.id).send(home_away)
      end

      def scores_for(game)
        game["competitions"].
          first["competitors"].each_with_object({}.with_indifferent_access) do |team, scores|
            scores[team["team"]["abbreviation"]] =
              { home_away: team["homeAway"], score: team["score"] }
          end
      end
    end
  end
end
