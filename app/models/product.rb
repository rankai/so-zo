class Product < ActiveRecord::Base

	belongs_to :product_template
	belongs_to :publish
	has_many   :product_images, dependent: :destroy
	has_many   :line_items
	has_many   :order_items
	belongs_to :state

	def self.generate_products(publish)
		# 2014040110063()2
		# need to create products
		@product_templates = ProductTemplate.all

		products_array = Array.new

		@product_templates.each do |template|

			publish_image = "#{Rails.root}/public" + "#{publish.publish_image.url}".split("?")[0]
			#publish_image_content_type = publish.publish_image.content_type.split("/")[1]
			#tmp_image = "#{Rails.root}/tmp/" + "#{Time.now.to_i}#{Time.now.to_i}.#{publish_image_content_type}"				
			tmp_product_image = "#{Rails.root}/tmp/" + "#{Time.now.to_i}#{Time.now.to_i}.png" 

			@product  = Product.new()
			@product.product_template_id = template.id
			@product.name = template.template_name
			@product.description = template.description
			@product.publish_id = publish.id

			@state = State.where(:name => "inactive").first
			@product.state = @state

			@base = Base.where(:title => "bonus_ratio").first
			@product.price = template.price * (1 + @base.detail.to_f)
			@product.base_price = template.price

			if @product.save

				#test
				#system "echo #{head_image} >> /home/kevin/test.log"
				#system "echo #{head_image_mask} >> /home/kevin/test.log"
				#system "echo #{publish_image} >> /home/kevin/test.log"
				#system "echo #{tmp_product_image} >> /home/kevin/test.log"
				#p "content_type: #{publish_image_content_type}"
				#p "cp #{publish_image} #{tmp_image}"
				#system "cp #{publish_image} #{tmp_image}"

				#   product	head image
				if template.head_image.present?
					head_image_mask = "#{Rails.root}/public" + "#{template.head_image_mask.url}".split("?")[0]
					head_image      = "#{Rails.root}/public" + "#{template.head_image.url}".split("?")[0]    
					
					composite(head_image, head_image_mask, publish_image, tmp_product_image)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_product_image)
					@product_image.product = @product

					@product_image.save
				end 
			    

				#   product	side image
				if template.side_image.present?
					side_image_mask = "#{Rails.root}/public" + "#{template.side_image_mask.url}".split("?")[0]
					side_image 	    = "#{Rails.root}/public" + "#{template.side_image.url}".split("?")[0]    

					composite(side_image, side_image_mask, publish_image, tmp_product_image)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_product_image)
					@product_image.product = @product

					@product_image.save
				end 

				#   product	back image
				if template.back_image.present?
					back_image_mask = "#{Rails.root}/public" + "#{template.back_image_mask.url}".split("?")[0]
					back_image 	    = "#{Rails.root}/public" + "#{template.back_image.url}".split("?")[0]    

					composite(back_image, back_image_mask, publish_image, tmp_product_image)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_product_image)
					@product_image.product = @product
					@product_image.save
				end 

				system "rm -f #{tmp_product_image}"
				products_array.push(@product)
			end

		end

		return products_array
	end


	private
	# template : tempalte image
	# publish  : publish image
	# mask 	   : template image mask
	# tmp      : output image
	def self.composite(template, mask, publish, tmp)
		p "convert \"#{mask}\" -compose atop \"#{publish}\" -gravity center -composite \"#{tmp}\""
		system "convert \"#{mask}\" -compose atop \"#{publish}\" -gravity center -composite \"#{tmp}\""
		system "convert \"#{tmp}\" -compose over \"#{template}\" -geometry +0+0 -composite \"#{tmp}\""
	end


end
