class ChangeGames < ActiveRecord::Migration
  def up
   remove_column :games, :home
   remove_column :games, :away
  end

  def down
  end
end
