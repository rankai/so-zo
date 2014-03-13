class AddMaskFieldsOnProductTempalte < ActiveRecord::Migration
  def change
  	add_attachment  :product_templates, :front_image_mask
  	add_attachment  :product_templates, :back_image_mask
  	add_attachment  :product_templates, :side_image_mask
  end
end
