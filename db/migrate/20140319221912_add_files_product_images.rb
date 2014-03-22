class AddFilesProductImages < ActiveRecord::Migration
  def change
  	add_attachment :product_images, :head_image
  	add_attachment :product_images, :back_image
  	add_attachment :product_images, :side_image
  end
end
