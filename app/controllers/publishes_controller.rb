class PublishesController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show, :top]
	
	respond_to :json, :html, :js

	# get personal works
	def works
		@publishes = current_user.publishes.all
	end

	def top
		#can specify top no
		top = params["top"].to_i
		@publishes = Publish.last(top)
		render partial: "top", object: @publishes
	end

	def index
		@publishes = Publish.all
	end

	def new 
	end

	def upload
	end

	def create
		# eatch Publish belongs to an user
		@publish = current_user.publishes.create(params[:publish].permit(:name, :description, :publish_category_id, :state_id, :publish_image))
		if @publish.save

			# should notice frontend
			#flash[:notice] = "Successfully uploaded"
			#redirect_to @illstration
			#products_array = Product.generate_products(@Publish)
			# do not understand

			#not here to produce products response
			#@products = Product.all
			#render :partial => "products/list", collection: @products

			render partial: "image", object: @publish

		else
			flash[:error] = "Upload failed"
			render 'new'
		end
	end

	def edit
		@publish = Publish.find(params[:id])

		if @publishl.update(params[:publish].permit(:name, :description))
			redirect_to @Publish
		else
			render 'edit'
		end
	end

	def show
		@publish = Publish.find(params[:id])
	end

	def destroy
		@publish = Publish.find(params[:id])
		@publish.destroy

		redirect_to illstrations_path
	end

end
