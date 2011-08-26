class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.float :spread
      t.integer :result
      t.integer :game_id
      t.integer :pick_set_id
      t.integer :team_id
      t.float :over_under
      t.boolean :is_over

      t.timestamps
    end
  end
end
