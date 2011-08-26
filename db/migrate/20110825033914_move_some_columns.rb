class MoveSomeColumns < ActiveRecord::Migration
  def up
    remove_column :pool_types, :min_players
    remove_column :pool_types, :max_players
    add_column :pools, :max_players, :integer
    add_column :pools, :min_players, :integer
  end

  def down
  end
end
