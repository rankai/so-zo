class AddFilesSupport < ActiveRecord::Migration
  def change

  	remove_column 	:users, :photo
  	add_attachment 	:users, :photo

  	remove_column 	:product_templates, :front_img_path
  	remove_column   :product_templates, :back_img_path
  	remove_column   :product_templates, :side_img_path
  	add_attachment  :product_templates, :front_image
  	add_attachment  :product_templates, :back_image
  	add_attachment  :product_templates, :side_image

  	remove_column   :illustrations, 	:ill_path
  	add_attachment	:illustrations, 	:ill_image
  end
end
