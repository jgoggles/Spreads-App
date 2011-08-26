class AddScoreToGamesTeams < ActiveRecord::Migration
  def change
    add_column :games_teams, :score, :integer
  end
end
