class Product < ActiveRecord::Base
	belongs_to :product_template
	belongs_to :illustration

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	has_attached_file :product_image, :styles => {:large => "1000x1000>", :medium => "300x300>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	#not set path for every user

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type :product_image, :content_type => /\Aimage\/.*\Z/

	#attr_accessible :product_image

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(product_image_content_type)
	end

	def self.generate_products(illustration)

			# need to create products
			@product_templates = ProductTemplate.all

			products_array = Array.new

			@product_templates.each do |template|

				front_image_mask_path = "#{Rails.root}/public" + "#{template.front_image_mask.url}".split("?")[0]
				front_image_path 	  = "#{Rails.root}/public" + "#{template.front_image.url}".split("?")[0]    
				ill_image_path 		  = "#{Rails.root}/public" + "#{illustration.ill_image.url}".split("?")[0]				
				tmp_image_path 		  = "#{Rails.root}/tmp/" + "#{Time.now.to_i}.png" 

				#test
				#system "echo #{front_image_path} >> /home/kevin/test.log"
				#system "echo #{front_image_mask_path} >> /home/kevin/test.log"
				#system "echo #{ill_image_path} >> /home/kevin/test.log"
				#system "echo #{tmp_image_path} >> /home/kevin/test.log"
				
			#   disable product	
				system "convert #{front_image_mask_path} -compose atop #{ill_image_path} -gravity center -composite #{tmp_image_path}"
				system "convert #{tmp_image_path} -compose over #{front_image_path} -geometry +0+0 -composite #{tmp_image_path}"

				@product = Product.new()
				@product.product_template_id = template.id
				@product.name = template.template_name
				@product.description = template.description
				@product.illustration_id = illustration.id
				@product.make_image(tmp_image_path)

				system "rm -f tmp_image_path"

				if @product.save
					products_array.push(@product)
				else
					return false
				end

			end

			return products_array
	end

	def make_image(name)
		#Dir.tmpdir
		file = File.join("#{name}")
		io = File.new(file)
		self.product_image = io
	end
end
