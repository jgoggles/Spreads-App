class CreatePoolUsers < ActiveRecord::Migration
  def change
    create_table :pool_users do |t|
      t.integer :pool_id
      t.integer :user_id
      t.boolean :pool_admin

      t.timestamps
    end
  end
end
