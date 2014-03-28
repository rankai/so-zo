class OrdersController < ApplicationController
	before_filter :authenticate_user!

	def index
	end

	def show
	end

	def new
	end

	def create
		@user = User.find(params[:user_id])
		@order = @user.orders.create(params[:order].permit(:sum, :state_id))
		# order_items
		@line_items = current_cart.line_items

		@line_items.each do |item| 
			@color   = Color.find(item.color_id)
			@size    = Size.find(item.size_id)
			@product = Product.find(item.product_id)
			@order_item = @order.order_items.create(product_id: @product.id, 
				color: @color.name, size: @size.name, count: item.quantity, 
				price: item.quantity * @product.price)
		end

		current_cart.destroy

		#should be redirect to pay at once
		render "confirm", :object => @order
	end

	def destroy
	end

end
