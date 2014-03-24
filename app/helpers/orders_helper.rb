module OrdersHelper
	def get_line_items 
		@line_items = LineItem.all
	end
end
