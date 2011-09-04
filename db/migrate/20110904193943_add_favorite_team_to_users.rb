class AddFavoriteTeamToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_nfl_team_id, :integer
  end
end
