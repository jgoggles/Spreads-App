class AddCountToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :count, :integer
  end
end
