class AddYearIdToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :year_id, :integer
  end
end
