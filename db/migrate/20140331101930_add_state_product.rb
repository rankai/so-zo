class AddStateProduct < ActiveRecord::Migration
  def change
  	add_column :products, :state_id, :integer
  end
end
