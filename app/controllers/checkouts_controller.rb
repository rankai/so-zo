class CheckoutsController < ApplicationController
	before_filter :authenticate_user!

	def wepay
		@order = Order.find(params[:order_id])
    	response = Checkout.pay(@order)
    	#save checkout_id to session
    	session[:checkout_id] = response['checkout_id']
		redirect_to "#{response['checkout_uri']}"
	end

	def result
		@order = Order.find(params[:order_id])
		response = Checkout.authorize(session[:checkout_id])

		if response['state'] == 'authorized'
			@state = State.where(:name => "paid").first
			@order.state = @state
			@order.update
			session[checkout_id] = nil
			
			render "result", :object => @order
		else 
			render @order
		end
	end
end
