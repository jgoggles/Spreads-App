class AddColumnsToPools < ActiveRecord::Migration
  def change
    add_column :pools, :private, :boolean
    add_column :pools, :password, :string
  end
end
