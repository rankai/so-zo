class AddFieldOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :order_number, :string, :null => false, :default => "#{Time.now.to_i}"
  end
end
