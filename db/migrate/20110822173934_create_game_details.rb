class CreateGameDetails < ActiveRecord::Migration
  def change
    create_table :game_details do |t|
      t.integer :game_id
      t.integer :team_id
      t.boolean :is_home
      t.integer :score

      t.timestamps
    end
  end
end
