class ModifyPayoutColumnsInPools < ActiveRecord::Migration
  def up
    change_column :pools, :first_place_payout, :float
    change_column :pools, :second_place_payout, :float
    change_column :pools, :third_place_payout, :float
    add_column :pools, :fourth_place_payout, :float
    add_column :pools, :fifth_place_payout, :float
  end

  def down
  end
end
