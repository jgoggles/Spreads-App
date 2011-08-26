class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.integer :user_id
      t.integer :pool_id
      t.integer :week_id
      t.integer :wins
      t.integer :losses
      t.integer :pushes
      t.integer :points
      t.integer :over_under_points

      t.timestamps
    end
  end
end
