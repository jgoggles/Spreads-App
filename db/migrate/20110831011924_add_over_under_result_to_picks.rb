class AddOverUnderResultToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :over_under_result, :integer
  end
end
