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
		# the order id is order number
		p params[:order_id]
		@order = Order.find_by_order_number(params[:order_id])

		if @order.nil?
			redirect_to user_orders_path(current_user), status: :bad_request, alert: t('flash.alerts.payment_failed')
		else

		response = Checkout.authorize(session[:checkout_id])

			if response
				if response['state'] == 'authorized'
					@state = State.find_by_name("paid")
					@order.state = @state
					if @order.update
						session[checkout_id] = nil
						render "result", :object => @order
					else
						redirect_to user_orders_path(current_user), status: :service_unavailable, alert: t('flash.alerts.payment_failed')
					end
				else 
					redirect_to user_orders_path(current_user), status: :bad_request, alert: t('flash.alerts.payment_failed')
				end
			else
				redirect_to user_orders_path(current_user), status: :request_timeout, alert: t('flash.alerts.payment_failed')
			end
		end
	end

	def checkout
		@order = Order.find(params[:order_id])
		render "checkout"
	end
end
