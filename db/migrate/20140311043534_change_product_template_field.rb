class ChangeProductTemplateField < ActiveRecord::Migration
    def change
  	add_column :product_templates, :template_category_id, :integer
  	add_column :product_templates, :intial_X, :integer
  	add_column :product_templates, :intial_Y, :integer
  	add_column :product_templates, :size_W, :integer
  	add_column :product_templates, :size_H, :integer
  	add_column :product_templates, :front_img_path, :string
  	add_column :product_templates, :back_img_path, :string
  	add_column :product_templates, :side_img_path, :string
  	remove_column :product_templates, :template_path
  	add_index :product_templates, :template_category_id
  end
end
