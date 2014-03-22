class ChangeFieldsOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :status, :integer
  	add_column :order_items, :color, :string
  end
end
