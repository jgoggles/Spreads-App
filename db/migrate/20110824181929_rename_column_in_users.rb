class RenameColumnInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :hased_id, :hashed_id
  end

  def down
  end
end
