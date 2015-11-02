class AddPayoutSpotsToPools < ActiveRecord::Migration
  def change
    add_column :pools, :sixth_place_payout, :float
    add_column :pools, :seventh_place_payout, :float
    add_column :pools, :eighth_place_payout, :float
  end
end
