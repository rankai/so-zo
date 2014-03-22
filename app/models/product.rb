class Product < ActiveRecord::Base

	belongs_to :product_template
	belongs_to :illustration
	has_many   :product_images
	has_many   :line_items

	def self.generate_products(illustration)

		# need to create products
		@product_templates = ProductTemplate.all

		products_array = Array.new

		@product_templates.each do |template|

			ill_image = "#{Rails.root}/public" + "#{illustration.ill_image.url}".split("?")[0]				
			tmp_image = "#{Rails.root}/tmp/" + "#{Time.now.to_i}.png" 

			@product  = Product.new()
			@product.product_template_id = template.id
			@product.name = template.template_name
			@product.description = template.description
			@product.illustration_id = illustration.id
			@product.price = template.price

			if @product.save

				#test
				#system "echo #{head_image} >> /home/kevin/test.log"
				#system "echo #{head_image_mask} >> /home/kevin/test.log"
				#system "echo #{ill_image} >> /home/kevin/test.log"
				#system "echo #{tmp_image} >> /home/kevin/test.log"
				
				#   product	head image
				if template.head_image.present?
					head_image_mask = "#{Rails.root}/public" + "#{template.head_image_mask.url}".split("?")[0]
					head_image      = "#{Rails.root}/public" + "#{template.head_image.url}".split("?")[0]    
					
					composite(head_image, head_image_mask, ill_image, tmp_image)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_image)
					@product_image.product = @product

					system "rm -f #{tmp_image}"

					@product_image.save
				end 
			    

				#   product	side image
				if template.side_image.present?
					side_image_mask = "#{Rails.root}/public" + "#{template.side_image_mask.url}".split("?")[0]
					side_image 	    = "#{Rails.root}/public" + "#{template.side_image.url}".split("?")[0]    

					composite(side_image, side_image_mask, ill_image, tmp_image)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_image)
					@product_image.product = @product

					system "rm -f #{tmp_image}"

					@product_image.save
				end 

				#   product	back image
				if template.back_image.present?
					back_image_mask = "#{Rails.root}/public" + "#{template.back_image_mask.url}".split("?")[0]
					back_image 	    = "#{Rails.root}/public" + "#{template.back_image.url}".split("?")[0]    

					composite(back_image, back_image_mask, ill_image, tmp_image)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_image)
					@product_image.product = @product

					system "rm -f #{tmp_image}"

					@product_image.save
				end 

				products_array.push(@product)
			end

		end

		return products_array
	end


	private
	# image    : tempalte image
	# ill 	   : illustration image
	# mask 	   : template image mask
	# tmp      : output image
	def self.composite(image, mask, ill, tmp)
		system "convert #{mask} -compose atop #{ill} -gravity center -composite #{tmp}"
		system "convert #{tmp} -compose over #{image} -geometry +0+0 -composite #{tmp}"
	end


end
