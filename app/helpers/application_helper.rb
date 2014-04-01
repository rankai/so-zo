module ApplicationHelper
	def get_about_us
		@base = Base.where(:title => "about_us").first
		@base.detail
	end

	def get_order_confirmed_message
		@base = Base.where(:title => "order_confirmed").first
		@base.detail
	end

	def my_bonus
		bonus = 0.00
		#@orders = Order.where(:user_id != current_user.id)
		@orders = Order.all
		@orders.each do |order|
			#p "order belongs to: #{order.user_id}"
			#p "order state: #{order.state.name}"
			if order.state.name == "completed" 
				order.order_items.each do |order_item|
					p "order_item for product: #{order_item.product.name}"
					p "product is made by : #{order_item.product.publish.user.name}"
					# should add column as the base price to products
					if(order_item.product.publish.user.id == current_user.id) 
						@product = order_item.product
						p "product base_price: #{@product.base_price}"
						p "product price: #{@product.price}"
						bonus += order_item.count * (@product.price - @product.base_price)
						p "this order_item make bonus to: #{bonus}"
					end
				end
			end
		end
		bonus
	end

	def get_my_products
		Product.joins(:publish).where('publishes.user_id = ?', current_user.id)
	end

	def get_products_on_template_category(category_id)
		get_my_products.joins(:product_template).where("product_templates.template_category_id = ?", category_id)
	end

	def get_my_product_sells
		state_id = State.where(:name => 'completed').first.id
		Product.joins(order_items: :order).joins(:publish).where("publishes.user_id = ? and orders.state_id = ?", 
			current_user.id, state_id)
	end

	def get_my_product_sells_on_template_category(category_id)
		get_my_product_sells.joins(:product_template).where("product_templates.template_category_id = ?", category_id)
	end


	# from publish helper
	def get_my_sells
		state_id = State.where(:name => 'completed').first.id
		Product.joins(order_items: :order).joins(:publish).where("publishes.user_id = ? and orders.state_id = ?", 
			current_user.id, state_id)
	end

	def get_my_sells_on_category(category_id)
		get_my_sells.joins(:publish).where("publishes.publish_category_id = ?", category_id)
	end

	def get_sells
		state_id = State.where(:name => 'completed').first.id
	end
end
