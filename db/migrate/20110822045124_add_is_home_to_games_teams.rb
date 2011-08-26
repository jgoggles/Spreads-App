class AddIsHomeToGamesTeams < ActiveRecord::Migration
  def change
    add_column :games_teams, :is_home, :boolean
  end
end
