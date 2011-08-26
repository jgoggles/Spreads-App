class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.datetime :date
      t.string :home
      t.string :away
      t.integer :home_score
      t.integer :away_score
      t.integer :week_id
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
