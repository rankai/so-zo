class OrdersController < ApplicationController
	require 'wepay.rb'

	before_filter :authenticate_user!

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

		render "confirmed", object: @order
	end

	def destroy
	end


	#def pay
	#
		# application settings
	#	account_id = 2105324745
	#	client_id  = 82270
	#	client_secret = '94721e7f05'
	#	access_token  = 'STAGE_c999d9482026c8d182aacf59b9e1c3e73d8d2d6b120f9aeac4ae8881d04c09dd'
	#
		# set _use_state to false for live environments
	#	wepay = WePay.new(client_id, client_secret, _use_stage = true)
 	#
		# create the checkout
	#	response = wepay.call('checkout/create', access_token, {
	#		:account_id      	=> account_id,
	#		:amount          	=> '24.95',
	#		:short_description 	=> 'A brand new soccer ball',
	#		:type			   	=> 'GOODS',
	#		:mode               => 'regular',
	#		:redirect_uri		=> 'home/index'
	#		})
	#
	#	p response
	#
	#end

end
