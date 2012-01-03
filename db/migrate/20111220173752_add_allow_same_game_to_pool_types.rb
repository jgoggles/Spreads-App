class AddAllowSameGameToPoolTypes < ActiveRecord::Migration
  def change
    add_column :pool_types, :allow_same_game, :boolean
  end
end
