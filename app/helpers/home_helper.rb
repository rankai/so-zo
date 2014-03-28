module HomeHelper
	def get_top_4_products
		Product.last(4)
	end

	def get_top_3_photos
		@publish_category = PublishCategory.where(:name => "photo").first
		@publish_category.publishes.last(3)
	end
end
