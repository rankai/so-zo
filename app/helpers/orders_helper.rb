module OrdersHelper
	def get_line_items
		@cart = Cart.find_by_id(session[:cart_id]) 		
		@line_items = @cart.line_items
	end

	def get_default_order_state
		state = State.where(:name => "confirmed").first
		state.id
	end

	def get_unpaid_count 
		state = State.where(:name => 'confirmed').first
		@unpaid_orders = current_user.orders.where(:state_id => state.id).count
	end

	def get_shipped_count
		state = State.where(:name => "shipped").first
		@unpaid_orders = current_user.orders.where(:state_id => state.id).count
	end
end
