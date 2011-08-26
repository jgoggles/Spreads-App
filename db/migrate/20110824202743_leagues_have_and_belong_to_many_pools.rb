class LeaguesHaveAndBelongToManyPools < ActiveRecord::Migration
  def self.up
    create_table :leagues_pools, :id => false do |t|
      t.references :league, :pool
    end
  end

  def self.down
    drop_table :leagues_pools
  end
end
