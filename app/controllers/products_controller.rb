class ProductsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show, :index]

	def preview
		@illustration = Illustration.find_by_id(params[:ill_id])	
		@products = Product.generate_products(@illustration)
		render partial: "list", object: @products
	end

	def index
	end

	def show
		@product = Product.find(params[:id])
		gon.product_id = @product.id
	end

	def edit
	end

	def destroy
	end

	# add to shopping cart
	def cart 
	end

	# list products which are commented most
	def top_comments
	end

	# list products which are bought most
	def top_buy
	end

	# list products which are added to customers' favorites 
	def top_fav
	end

	def top
		#can specify top no
		top = params["top"].to_i
		@products = Product.last(top)
		render partial: "top", object: @products
	end
 
 	# any others 
end
