class ChangeStatusOrders < ActiveRecord::Migration
  def change
  	rename_column :orders, :status, :state_id
  end
end
