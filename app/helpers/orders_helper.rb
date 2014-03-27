module OrdersHelper
	def get_line_items
		@cart = Cart.find_by_id(session[:cart_id]) 		
		@line_items = @cart.line_items
	end

		def get_default_order_state
		state = State.where(:name => "confirmed").first
		state.id
	end
end
