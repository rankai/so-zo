class ProductsController < ApplicationController
	def preview
		@illustration = Illustration.find_by_id(params[:ill_id])	
		@products = Product.generate_products(@illustration)
		render partial: "list", collection: @products
	end

	def index
	end

	def show
	end

	def edit
	end

	def destroy
	end

end
