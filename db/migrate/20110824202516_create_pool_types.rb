class CreatePoolTypes < ActiveRecord::Migration
  def change
    create_table :pool_types do |t|
      t.string :name
      t.integer :max_picks
      t.integer :min_picks
      t.integer :min_players
      t.integer :max_players
      t.boolean :spreads
      t.boolean :over_under
      t.boolean :is_tiebreaker

      t.timestamps
    end
  end
end
