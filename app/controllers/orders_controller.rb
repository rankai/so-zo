class OrdersController < ApplicationController
	before_filter :authenticate_user!

	def index
		if params[:search].present?
			@orders = Order.search(params[:search], current_user)
		elsif params[:created_at] || params[:state]
			#Product.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
			time = "%"
			if params[:created_at] != 'all'
				time = params[:created_at].to_i.days.ago
			end
			state_id = "%"
			if params[:state] != 'all'
				@state = State.where(:name => params[:state]).first
				state_id = @state.id
			end		
			@orders = current_user.orders.where('created_at > ? and state_id like ?', time, state_id)
		else
			@orders = current_user.orders.all
		end
	end

	def update
		@order = Order.find(params[:id])
		if @order.update_attribute(params[:state_id])
			render 
		else
		end
	end

	def show
	end

	def new
	end

	def create
		@user = User.find(params[:user_id])
		#@order = @user.orders.create(params[:order].permit(:sum, :state_id))
		@order = @user.orders.build
		@order.sum = params[:order][:sum]
		@order.state_id = params[:order][:state_id]
		@order.order_number = Time.now.to_i

		if @order.save

			# order_items
			@line_items = current_cart.line_items

			@line_items.each do |item| 
				@color   = Color.find(item.color_id)
				@size    = Size.find(item.size_id)
				@product = Product.find(item.product_id)
				if !@order.order_items.create(product: @product, 
					color: @color.name, size: @size.name, count: item.quantity, 
					price: item.quantity * @product.price)

					@order.destroy
					redirect_to action: 'new', status: :internal_server_error, :alert => t('flash.alerts.order_created_alert')
				end
			end

			current_cart.destroy
			#format.html {render "confirm", :object => @order, status: :created, :notice => t('flash.notices.order_created')}
			render "confirm", :object => @order, status: :created
			#format.json {}
		else
			fredirect_to action: 'new', status: :internal_server_error, :alert => t('flash.alerts.order_created_alert')
		end
	end

	def destroy
		@order = Order.find(params[:id])
		if @order.state.name == "confirmed"
			@state = State.where(:name => "deleted").first
			if @order.update_attribute(:state, @state)
				redirect_to user_orders_path(current_user), :notice => t('flash.notices.order_deleted')
			end
		else
			redirect_to user_orders_path(current_user), status: :forbidden, :alert => t('flash.alerts.order_deleted_forbid')
		end
	end

end
