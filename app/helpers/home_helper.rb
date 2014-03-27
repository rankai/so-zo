module HomeHelper
	def get_top_4_products
		Product.last(4)
	end

	def get_top_3_publishes
		Publish.last(3)
	end
end
