class AddHashedIdToPickSets < ActiveRecord::Migration
  def change
    add_column :pick_sets, :hashed_id, :string
  end
end
