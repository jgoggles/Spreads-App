class AddPaidToPoolUsers < ActiveRecord::Migration
  def change
    add_column :pool_users, :paid, :boolean
  end
end
