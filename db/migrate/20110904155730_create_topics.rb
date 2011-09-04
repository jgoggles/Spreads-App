class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :pool_id
      t.integer :user_id
      t.string :title

      t.timestamps
    end
  end
end
