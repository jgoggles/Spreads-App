class AddYearIdToPools < ActiveRecord::Migration
  def change
    add_column :pools, :year_id, :integer
  end
end
