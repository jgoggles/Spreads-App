class CreatePickSets < ActiveRecord::Migration
  def change
    create_table :pick_sets do |t|
      t.integer :user_id
      t.integer :pool_id
      t.integer :week_id

      t.timestamps
    end
  end
end
