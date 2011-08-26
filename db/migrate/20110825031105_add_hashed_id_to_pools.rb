class AddHashedIdToPools < ActiveRecord::Migration
  def change
    add_column :pools, :hashed_id, :string
  end
end
