class OrdersController < ApplicationController
	before_filter :authenticate_user!

	def index

		@user = User.find(params[:user_id])

		if params[:search]
			@orders = Order.search(params[:search], current_user)
		elsif params[:created_at] || params[:state]
			#Product.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
			time = "%"
			if params[:created_at] != 'all'
				time = params[:created_at].to_i.days.ago
			end
			state_id = "%"
			if params[:state] != 'all'
				@state = State.find_by(:name, params[:state])
				state_id = @state.id
			end		
			@orders = current_user.orders.joins(:order_items).where('orders.created_at > ? 
				AND orders.state_id like ?', time, state_id).order("orders.created_at asc").distinct("orders.id")
		else
			@orders = current_user.orders.joins(:order_items).order("orders.created_at asc").distinct("orders.id")
			p "orders count : #{@orders.count}"
			@orders
		end
	end

	def update
		@order = Order.find(params[:id])
		if @order.update_attribute(params[:state_id])
=begin
			@state = State.find_by(:name, "completed")
			p "#{@state.id}: #{@state.name}"
			if @state.id == params[:state_id]
				# TODO: Assign incomees to each author
				@order.order_items do |item|
					@user = User.find_by(:id, item.user_id)
					sum = item.price.to_f * item.count
					if @user.nil?
						@income = income.new
						@income.user_id = item.user_id
						@income.amount = sum
						@user.save 
					else
						@income.update_attribute(:amount, @income.amount + sum)
					end				
				end
			end
=end

			render
		end
	end

	def show
	end

	def new
	end

	def create

		items_count = current_cart.line_items.count
		p "1. current cart has #{items_count} items---------------------"


		if items_count == 0 
			p "already submitted---------------------"
			#redirect_to user_orders_path(current_user), status: :method_not_allowed, :alert => t('flash.alerts.order_already_submitted')
			redirect_to user_orders_path(current_user), :alert => t('flash.alerts.order_already_submitted')
		else
			@user = User.find(params[:user_id])
			#@order = @user.orders.create(params[:order].permit(:sum, :state_id))
			@order = @user.orders.build
			@order.sum = params[:order][:sum]
			@order.state_id = params[:order][:state_id]
			@order.order_number = Time.now.to_i

			if @order.save
				p "new submission--------------------------"
				# order_items
				@line_items = current_cart.line_items

				p "2. current cart has #{items_count} items------------------------"

				@line_items.each do |item| 
					@color   = Color.find(item.color_id)
					@size    = Size.find(item.size_id)
					@product = Product.find(item.product_id)

					product_image = "#{Rails.root}/public" + "#{@product.product_images.first.product_image.url(:medium)}".split("?")[0]

					@order_item = @order.order_items.build()
					@order_item.product = @product
					@order_item.color = @color.name
					@order_item.size = @size.name
					@order_item.count = item.quantity
					@order_item.price = item.quantity * @product.price
					@order_item.make_image(product_image)
					
					if not @order_item.save
						@order.destroy
						redirect_to action: 'new', status: :internal_server_error, :alert => t('flash.alerts.order_created_alert')
					end
				end

				#session[:cart_id] = nil
				current_cart.destroy
				current_cart
				#format.html {render "confirm", :object => @order, status: :created, :notice => t('flash.notices.order_created')}
				render "confirm", :object => @order, status: :created
				#format.json {}
			else
				redirect_to action: 'new', status: :internal_server_error, :alert => t('flash.alerts.order_created_alert')
			end
		end
	end

	def destroy
		@order = Order.find(params[:id])
		if @order.state.name == "confirmed"
			if @order.destroy
				redirect_to user_orders_path(current_user), :notice => t('flash.notices.order_deleted')
			end
		else
			redirect_to user_orders_path(current_user), status: :forbidden, :alert => t('flash.alerts.order_deleted_forbid')
		end
	end

end
