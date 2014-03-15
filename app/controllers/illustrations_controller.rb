class IllustrationsController < ApplicationController
	def index
		#@illstrations = Illstration.all
	end

	def new 
	end

	def upload
	end

	def create
		@illustration = Illustration.new(params[:illustration].permit(:name, :description, :ill_image))
		if @illustration.save
			flash[:notice] = "Successfully uploaded"
			#redirect_to @illstration

			# need to create products
			@product_templates = ProductTemplate.all

			@product_templates.each do |template|

				front_image_mask_path = "#{Rails.root}/public" + "#{template.front_image_mask.url}".split("?")[0]
				front_image_path 	  = "#{Rails.root}/public" + "#{template.front_image.url}".split("?")[0]    
				ill_image_path 		  = "#{Rails.root}/public" + "#{@illustration.ill_image.url}".split("?")[0]			
				tmp_image_path 		  = "#{Rails.root}/tmp/" + "#{Time.now.to_i}.png" 

				#test
				#system "echo #{front_image_path} >> /home/kevin/test.log"
				#system "echo #{front_image_mask_path} >> /home/kevin/test.log"
				#system "echo #{ill_image_path} >> /home/kevin/test.log"
				#system "echo #{tmp_image_path} >> /home/kevin/test.log"
				
				system "convert #{front_image_mask_path} -compose atop #{ill_image_path} -gravity center -composite #{tmp_image_path}"
				system "convert #{tmp_image_path} -compose over #{front_image_path} -geometry +0+0 -composite #{tmp_image_path}"

				@product = Product.new()
				@product.template_id = template.id
				@product.illustration_id = @illustration.id
				@product.make_image(tmp_image_path)
				@product.save
			end

			# should notice frontend

			render 'home/index'
		else
			render 'new'
		end
	end

	def edit
		@illustration = Illustration.find(params[:id])

		if @illustration.update(params[:illustration].permit(:name, :description))
			redirect_to @illustration
		else
			render 'edit'
		end
	end

	def show
		@illustration = Illustration.find(params[:id])
	end

	def destroy
		@illustration = Illustration.find(params[:id])
		@illustration.destroy

		redirect_to illstrations_path
	end

end
