class AddLogoToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :logo, :string
  end
end
