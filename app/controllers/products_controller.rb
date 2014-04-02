class ProductsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show, :index]

	def preview
		@publish = Publish.find_by_id(params[:publish_id])	
		@products = Product.generate_products(@publish)
		render partial: "list", object: @products
	end

	def index

		@state = State.where(:name => "active").first

		if params[:user_id]
			
			@publishes = nil
			if params[:product_category] || params[:sell]

				category_id = "%"
				if params[:product_category] != 'all'
					category_id = TemplateCategory.where(:name => params[:product_category]).first.id
				end
				

				@products = current_user.products.joins(:product_template).where('product_templates.template_category_id LIKE ? AND products.state_id = ?', category_id, @state.id)

				if params[:sell] == '1'
					@products = Product.joins(:order_items).joins(:publish).joins(:product_template).where("publishes.user_id = ? AND product_templates.template_category_id LIKE ? AND products.state_id = ?",
					 current_user.id, category_id, @state.id)
				end

			else

			@products = current_user.products


			end

			render "products", object: @products, layout: "works"


		else
			@products = Product.where(:state => @state)
		end
	end

	def show
		@product = Product.find(params[:id])
		gon.product_id = @product.id
	end

	def edit
	end

	def update
		@product = Product.find(params[:id])
		
		respond_to do |format|
			
			if @product.update_attribute(:price, params[:price])
				format.text{render text: t('flash.notices.product_price_updated')}
			else
				format.text{render text: t('flash.alerts.product_price_updated_alert'), status: :internal_server_error}
			end
		end

	end

	def setpriceonce
		@publish = Publish.find_by_id(params[:publish_id])
		@products = @publish.products
		
		respond_to do |format|

			if params[:price_ratio] 
				price_radio = params[:price_ratio].to_f / 100

				@products.each do |product|
					current_price = product.price;
					new_price = current_price * (1 + price_radio) 
					if product.update_attribute(:price, new_price)
					else
						format.text{render text: t('flash.alerts.product_price_updated_alert'), status: :internal_server_error}
					end
				end

				format.text{render text: t('flash.notices.product_price_updated')}

			else
				format.text{render text: t('flash.alerts.product_price_updated_alert'), status: :not_acceptable}
			end
		end

	end

	def destroy
		@product = Product.find(params[:id])

		respond_to do |format|

			#@state = State.where(:name => "deleted").first

			#in_order_count = @product.order_items.count

			state_id = State.where(:name => "completed").first.id
			in_order_count = count_in_order = Product.joins(order_items: :order).where("products.id = ? and orders.state_id = ?", 
				@product.id, state_id).count

			in_cart_count = @product.line_items.count
			publish_product_count = @product.publish.products.count - 1 # exclusion this one

			p "product in cart: #{in_cart_count}, in order: #{in_order_count}, the pulish has another #{publish_product_count} products"

			#if @publish.update_attribute(:state, @state)
			if publish_product_count > 0 

				if @product.state.name == "inactive"

					if @product.destroy
						format.text{render text: t('t.flash.notices.product_deleted')}
					else
						format.text{render text: ('flash.alerts.product_deleted_alert'), status: :internal_server_error}
					end
				
				else	

					if in_order_count == 0 && in_cart_count == 0
						if @product.destroy
							format.text{render text: t('t.flash.notices.product_deleted')}
						else
							format.text{render text: ('flash.alerts.product_deleted_alert'), status: :internal_server_error}
						end
					else
						format.text{render text: t('flash.alerts.product_deleted_forbid'), status: :forbidden}
					end

				end

			else
				format.text{render text: t('flash.alerts.last_product_deleted_forbid'), status: :forbidden}
			end
			
		end
	end

	# add to shopping cart
	def cart 
	end

	# list products which are commented most
	def top_comments
	end

	# list products which are bought most
	def top_buy
	end

	# list products which are added to customers' favorites 
	def top_fav
	end

	def top

		# make orders

		state_id = State.where(:name => "completed").first.id
		@products = Array.new
		@top_products = Product.joins(order_items: :order).where("orders.state_id = ?", state_id).count(:group => "products.id", :order => 'count_all asc')
		#@hot_publishes.each do |item|
		#	p item
		#	@publish = Publish.find(item[0])
		#	@publishes.push(@publish)
		#end
		render "top", object: @top_products

	end
 
 	# any others 
end
