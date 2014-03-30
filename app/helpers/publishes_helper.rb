module PublishesHelper
	def get_default_state
		state = State.where(:name => "show").first
		state.id
	end

	def get_my_sells
		Product.joins(:order_items).joins(:publish).where("publishes.user_id LIKE ?", current_user.id)
	end

	def get_my_sells_on_category(category_id)
		get_my_sells.joins(:publish).where("publishes.publish_category_id LIKE ?", category_id)
	end

end
