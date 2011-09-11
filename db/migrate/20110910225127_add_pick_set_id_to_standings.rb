class AddPickSetIdToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :pick_set_id, :integer
  end
end
