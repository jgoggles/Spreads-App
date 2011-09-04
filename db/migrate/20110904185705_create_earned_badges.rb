class CreateEarnedBadges < ActiveRecord::Migration
  def change
    create_table :earned_badges do |t|
      t.integer :badge_id
      t.integer :user_id
      t.integer :pool_id
      t.integer :week_id
      t.integer :pick_set_id
      t.integer :pick_id

      t.timestamps
    end
  end
end
