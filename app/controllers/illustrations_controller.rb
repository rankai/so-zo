class IllustrationsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show, :top]
	
	respond_to :json, :html, :js

	# get personal works
	def works
		@illustrations = current_user.illustrations.all
	end

	def top
		#can specify top no
		top = params["top"].to_i
		@illustrations = Illustration.last(top)
		render partial: "top", object: @illustrations
	end

	def index
		@illustrations = Illustration.all
	end

	def new 
	end

	def upload
	end

	def create
		# eatch illustration belongs to an user
		@illustration = current_user.illustrations.create(params[:illustration].permit(:name, :description, :ill_image))
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
