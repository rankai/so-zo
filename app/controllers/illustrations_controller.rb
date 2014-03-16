class IllustrationsController < ApplicationController
	respond_to :json, :html, :js

	def index
		@illustrations = Illustration.all
	end

	def new 
	end

	def upload
	end

	def create
		@illustration = Illustration.new(params[:illustration].permit(:name, :description, :ill_image))
		if @illustration.save

			# should notice frontend
			#flash[:notice] = "Successfully uploaded"
			#redirect_to @illstration
			#products_array = Product.generate_products(@illustration)
			# do not understand

			#not here to produce products response
			#@products = Product.all
			#render :partial => "products/list", collection: @products

			render partial: "image", illustration: @illustration

		else
			flash[:error] = "Upload failed"
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
