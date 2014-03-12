class ChangeProductField < ActiveRecord::Migration
  def change
  	add_column :products, :template_id, :integer
  	add_column :products, :illustration_id, :integer
  	add_column :products, :name, :string
  	add_column :products, :description, :string
  	add_column :products, :position_X, :integer
  	add_column :products, :position_Y, :integer
  	add_column :products, :degree, :integer
  	add_column :products, :ill_size_W, :integer
  	add_column :products, :ill_size_H, :integer
  	add_index  :products, [:template_id, :illustration_id]
  end
end
