class RemoveScoresFromGames < ActiveRecord::Migration
  def up
   remove_column :games, :away_score
   remove_column :games, :home_score
  end

  def down
  end
end
