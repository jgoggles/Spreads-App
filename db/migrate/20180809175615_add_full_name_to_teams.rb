class AddFullNameToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :full_name, :string

    Team.all.each do |team|
      team.update(full_name: team._full_name)
    end
  end

end
