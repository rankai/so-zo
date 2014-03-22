class ChangeProductImages < ActiveRecord::Migration
  def change
  	remove_attachment :product_images, :head_image
  	remove_attachment :product_images, :back_image
  	remove_attachment :product_images, :side_image

  	add_attachment    :product_images, :product_image
  end
end
