module ApplicationHelper
    # 2014-04-06 22:53 update find_by_* to find_by(*:, "")
	def get_about_us
		@base = Base.find_by(title: "about_us")
		@base.detail
	end

	def get_order_confirmed_message
		@base = Base.find_by(title: "order_confirmed")
		@base.detail
	end

	def active_product_state
		@state = State.find_by(name: 'active')
	end

	def total_publishes(user)  
        Publish.joins(products: :product_images).where("products.state_id = ? AND publishes.user_id = ?", 
				active_product_state.id, user.id).order("publishes.created_at asc").distinct("publishes.id")
	end


	def cart_quantity
		current_cart.line_items.count		
	end

    # FIXME - When deleted product or publish, order_item.product would be null
    # OPTIMIZEME - 1.income is calculated and newed here, should be done once the order 
    #              is completed, but it's hard to customize rails_admin right now
    #              2. when product is deleted (or publish is deleted), order_item cannot
    #              access the product and publish anymore, so the income also cannot be collected
	def user_bonus(user)
		bonus = 0.00
=begin
		@income = Income.find_by(:user_id, user.id)
		if @income.nil?
			@new_income = Income.new
			@new_income.user = user
=end

			@orders = Order.where(:user_id == user.id)
			@orders.each do |order|
				if order.state.name == "completed" 
					order.order_items.each do |order_item|
						if order_item.product.nil?
						else
							if(order_item.product.publish.user.id == user.id)
								@product = order_item.product
						    	bonus += order_item.count * (@product.price - @product.base_price)
							end
						end
					end
				end
			end
=begin
			@new_income.amount = bonus
			@new_income.save
		else
			bonus = @income.amount
		end
=end


		bonus
	end

	def publish_categories
		@categories = PublishCategory.all
	end

	def product_categories
		@categories = TemplateCategory.all
	end

	def total_products(user)
		Product.joins(:publish).joins(:product_images).where('publishes.user_id = ? AND products.state_id = ?', user.id, active_product_state.id).distinct("products.id")
	end

	def get_products_on_template_category(user, category)
		total_products(user).joins(:product_template).where("product_templates.template_category_id = ?", category.id)
	end

	def get_product_sells(user)
		state_id = State.where(:name => 'completed').first.id
		Product.joins(order_items: :order).joins(:publish).where("publishes.user_id = ? AND orders.state_id = ? AND products.state_id = ?", 
			user.id, state_id, active_product_state.id)
	end

	def get_product_sells_on_template_category(user, category)
		get_product_sells(user).joins(:product_template).where("product_templates.template_category_id = ?", category.id)
	end


	def my_active_orders
		@state = State.where(:name => "deleted").first
		if not @state.nil?
			Order.joins(:user).where("orders.state_id != ? AND users.id = ?", @state.id, current_user.id).count
		end

		0
	end

	# from publish helper
	def get_sells(user)
		state_id = State.where(:name => 'completed').first.id
		Product.joins(order_items: :order).joins(:publish).where("publishes.user_id = ? AND orders.state_id = ? AND products.state_id = ?", 
			user.id, state_id, active_product_state.id)
	end

	def get_sells_on_category(user, category)
		get_sells(user).joins(:publish).where("publishes.publish_category_id = ?", category.id)
	end

	def short_text(max, text)
		if text.length > max
			short_version = text[0..max] + "..."
		else
			text
		end
	end

end
