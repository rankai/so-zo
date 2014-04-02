class AddFieldsTemplates < ActiveRecord::Migration
  def change
  	add_column :product_templates, :position_X, :integer
  	add_column :product_templates, :position_Y, :integer
  	add_column :product_templates, :size_X, :integer
  	add_column :product_templates, :size_Y, :integer
  	add_column :product_templates, :degree, :integer
  	add_column :product_templates, :if_zoom, :integer
  end
end
