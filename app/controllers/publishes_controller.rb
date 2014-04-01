class PublishesController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show, :top]
	
	respond_to :json, :html, :js

	def top
		#can specify top no
		top = params["top"].to_i
		@publishes = Publish.last(top)
		render partial: "top", object: @publishes
	end

	def hot
		# already added to cart, but not make orders
		@publishes = Array.new
		@hot_publishes = Publish.joins(:line_items).count(:group => "publishes.id", :order => 'count_all asc')
		#@hot_publishes.each do |item|
		#	p item
		#	@publish = Publish.find(item[0])
		#	@publishes.push(@publish)
		#end
		render "hot", object: @hot_publishes
	end

	def index
		if params[:user_id] 
			@publishes = nil
			if params[:publish_category] || params[:sell]

				category_id = "%"
				if params[:publish_category] != 'all'
					category_id = PublishCategory.where(:name => params[:publish_category]).first.id
				end

				

				@publishes = current_user.publishes.where('publish_category_id LIKE ?', category_id)

				if params[:sell] == '1'
					@publishes = Publish.joins(products: [:order_items]).where("publishes.user_id LIKE ? and publishes.publish_category_id LIKE ?", current_user.id, category_id)
				end

			else

			@publishes = current_user.publishes


			end

			render 'works', object: @publishes, :layout => "works"
		else
			@publishes = Publish.all
		end	
	end

	def new 
	end

	def upload
	end

	def create
		# eatch Publish belongs to an user
		@publish = current_user.publishes.create(params[:publish].permit(:name, :description, :publish_category_id, :state_id, :publish_image))
		if @publish.save

			# should notice frontend
			#flash[:notice] = "Successfully uploaded"
			#redirect_to @illstration
			#products_array = Product.generate_products(@Publish)
			# do not understand

			#not here to produce products response
			#@products = Product.all
			#render :partial => "products/list", collection: @products

			render partial: "image", object: @publish

		else
			render 'new', status: :internal_server_error, :alert => t('flash.alerts.publish_upload_alert')
		end
	end

	def edit
		@publish = Publish.find(params[:id])

		if @publishl.update(params[:publish].permit(:name, :description))
			redirect_to @Publish
		else
			render 'edit'
		end
	end

	def show
		@publish = Publish.find(params[:id])
	end

	def destroy
		@publish = Publish.find(params[:id])

		state_id = State.where(:name => "completed").first.id
		count_in_order = Product.joins(order_items: :order).joins(:publish).where("publishes.id = ? and orders.state_id = ?", 
			@publish.id, state_id).count
		count_in_cart  = Product.joins(:line_items).joins(:publish).where("publishes.id = ? ", @publish.id).count

		p "hahah: #{count_in_order}, #{count_in_cart}"

		respond_to do |format|

			if count_in_cart == 0 && count_in_order == 0

				if @publish.destroy				
					format.text{render text: t('flash.notices.publish_deleted'), status: :ok}
				else
					format.text{render text: t('flash.alerts.publish_deleted_alert'), status: :internal_server_error}
				end
			else
				format.text{render text: t('flash.alerts.publish_deleted_forbid'), status: :forbidden }
			end
		end
	end

end
