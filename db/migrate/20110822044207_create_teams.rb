class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :city
      t.string :nickname
      t.integer :league_id
      t.integer :conference_id
      t.integer :division_id

      t.timestamps
    end
  end
end
