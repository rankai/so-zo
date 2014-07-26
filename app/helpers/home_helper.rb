module HomeHelper
	def get_latest_products(count)
		@products = Product.joins(:product_images).where("products.state_id = ?", 
			active_product_state.id).distinct("products.id").order("products.created_at desc").limit(count)
	end

	def get_latest_photos(count)
		@publish_category = PublishCategory.find_by_name("photo")
		Publish.joins(products: :product_images).where("publishes.publish_category_id =? AND products.state_id = ?", 
			@publish_category.id, active_product_state.id).distinct("publishes.id").order("publishes.created_at desc").limit(count)
	end

	def get_products_by_statistics(action, count)
		Product.joins(:product_images).joins('LEFT OUTER JOIN statistics ON statistics.object_id = products.id').where("products.state_id = ? 
			AND statistics.action = ? AND statistics.object_type = 'C'", active_product_state.id, action).distinct("products.id").order("statistics.count desc").limit(count)
	end
end