class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.integer :pool_type_id
      t.string :name
      t.boolean :free
      t.integer :cost
      t.integer :first_place_payout
      t.integer :second_place_payout
      t.integer :third_place_payout

      t.timestamps
    end
  end
end
