class Product < ActiveRecord::Base

	belongs_to :product_template
	belongs_to :publish
	has_many   :product_images, dependent: :destroy
	has_many   :line_items, dependent: :destroy
	has_many   :order_items, dependent: :nullify
	belongs_to :state

    # OPTIMIZEME: only generate one
	def self.generate_products(publish)
		# 2014040110063()2
		# need to create products
		 @product_templates = ProductTemplate.all

		products_array = Array.new

		@product_templates.each do |template|

			position_X = -1
			position_Y = -1
			size_X = -1
			size_Y = -1
			degree = 0
			if_zoom = 0

			# position
			if template.position_X.present? and template.position_Y.present?
				position_X = template.position_X
				position_Y = template.position_Y
			end 

			# if room
			if template.if_zoom.present?
				if_zoom = template.if_zoom

				# size
				if template.size_X.present? and template.size_Y.present?
					size_X = template.size_X
					size_Y = template.size_Y
				end
			
			end

			# degree
			if template.degree.present?
				degree = template.degree
			end


			publish_image = "#{Rails.root}/public" + "#{publish.publish_image.url(:large)}".split("?")[0]
			#publish_image_content_type = publish.publish_image.content_type.split("/")[1]
			#tmp_image = "#{Rails.root}/tmp/" + "#{Time.now.to_i}#{Time.now.to_i}.#{publish_image_content_type}"				
			tmp_product_image = "#{Rails.root}/tmp/" + "#{Time.now.to_i}#{Time.now.to_i}.png" 

			@product  = Product.new()
			@product.product_template_id = template.id
			@product.name = template.template_name
			@product.description = template.description
			@product.publish_id = publish.id

			@state = State.find_by_name("inactive")
			@product.state = @state

			@base = Base.find_by_title("bonus_ratio")
			if @base.nil?
				@product.price = template.price
			else
				@product.price = template.price * (1 + @base.detail.to_f)
			end
			
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
					
					composite(head_image, head_image_mask, publish_image, tmp_product_image, position_Y, position_Y, size_X, size_Y, degree, if_zoom)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_product_image)
					@product_image.product = @product

					if not @product_image.save
						publish.destroy
						return nil
					end
				end 
			    

				#   product	side image
				if template.side_image.present?
					side_image_mask = "#{Rails.root}/public" + "#{template.side_image_mask.url}".split("?")[0]
					side_image 	    = "#{Rails.root}/public" + "#{template.side_image.url}".split("?")[0]    

					composite(side_image, side_image_mask, publish_image, tmp_product_image, position_Y, position_Y, size_X, size_Y, degree, if_zoom)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_product_image)
					@product_image.product = @product

					if not @product_image.save
						publish.destroy
						return nil
					end
				end 

				#   product	back image
				if template.back_image.present?
					back_image_mask = "#{Rails.root}/public" + "#{template.back_image_mask.url}".split("?")[0]
					back_image 	    = "#{Rails.root}/public" + "#{template.back_image.url}".split("?")[0]    

					composite(back_image, back_image_mask, publish_image, tmp_product_image, position_Y, position_Y, size_X, size_Y, degree, if_zoom)
					
					@product_image = ProductImage.new();
					@product_image.make_image(tmp_product_image)
					@product_image.product = @product
					
					if not @product_image.save
						publish.destroy
						return nil
					end
				end 

				system "rm -f #{tmp_product_image}"
				products_array.push(@product)

			else
				publish.destroy
				return nil
			end

		end

		return products_array
	end


	private
	# template : tempalte image
	# publish  : publish image
	# mask 	   : template image mask
	# tmp      : output image
	def self.composite(template, mask, publish, tmp, position_X, position_Y, size_X, size_Y, degree, if_zoom)
		p "convert \"#{mask}\" -compose atop \"#{publish}\" -gravity center -composite \"#{tmp}\""

		zoomed = 0
		tmp_image = "#{Rails.root}/tmp/" + "#{Time.now.to_i}#{Time.now.to_i}.png"

		# zoom
		if if_zoom == 1 
			if size_X != -1 and size_Y != -1
				    p "convert \"#{publish}\" -auto-orient -resize \"#{size_X}x#{size_Y}\" \"#{tmp_image}\""
					system "convert \"#{publish}\"  -resize \"#{size_X}x#{size_Y}\" \"#{tmp_image}\""
					zoomed = 1
			end
		end

		# rotate
		if(zoomed == 1) 
			p "convert \"#{tmp_image}\" -rotate #{degree} \"#{tmp_image}\""
			system "convert \"#{tmp_image}\" -rotate #{degree} \"#{tmp_image}\""
		else
			system "convert \"#{publish}\" -rotate #{degree} \"#{tmp_image}\""
		end
		

		if position_X != -1 and position_Y != -1
			p 
			system "convert \"#{mask}\" -compose atop \"#{tmp_image}\" -geometry +#{position_X}+#{position_Y} -composite \"#{tmp}\""
		else
			system "convert \"#{mask}\" -compose atop \"#{tmp_image}\" -gravity center -composite \"#{tmp}\""
		end


		#system "rm -f #{tmp_image}"
		system "convert \"#{tmp}\" -compose over \"#{template}\" -geometry +0+0 -composite \"#{tmp}\""

	end


end
