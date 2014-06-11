class PublishesController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show, :hot, :works]
	
	respond_to :json, :html, :js
    
    # 2014-04-06 22:57 update find_by_* to find_by(*, "")
    
    # for hot 2014-04-06 23:13 optimize category query
	def hot
		# already added to cart, but not make orders
		@publishes = Array.new
		@hot_publishes = Publish.joins(:line_items)
		#@hot_publishes = Publish.joins(:line_items).count(:group => "publishes.id", 
		#			:order => 'count_all asc', :limit => 10)

		if params[:publish_category] 
			@category = PublishCategory.find_by(name: params[:publish_category])
			if @category.nil?			
			else
				category_id = @category.id
				#@hot_publishes = Publish.joins(:line_items).where('publishes.publish_category_id LIKE ?', 
				#	category_id).count(:group => "publishes.id", :order => 'count_all asc', :limit => 10)
                @hot_publishes = @hot_publishes.where("publishes.publish_category_id = ?", category_id)
			end
		end

		@hot_publishes =  @hot_publishes.count(:group => "publishes.id", 
					:order => 'count_all asc', :limit => 10)

		render "hot", object: @hot_publishes
	end

	def index

		# for meny
		# @categories = PublishCategory.all => change to helper

		@state = State.find_by(name: "active")

		@publishes = nil

		if params[:publish_category]

			p "parameter: #{params[:publish_category]}, #{params[:sell]}"

			category_id = "%"
			if params[:publish_category] != 'all'
				@category = PublishCategory.find_by(name: params[:publish_category])
				if @category.nil?
				else
					category_id = @category.id
				end
			end
			
			p "parameter: #{params[:publish_category]}:#{category_id}, #{params[:sell]}"

			@publishes = Publish.joins(products: :product_images).where('publishes.publish_category_id LIKE ? AND products.state_id = ?', 
			category_id, @state.id).distinct("publishes.id").order("publishes.created_at desc").page(params[:page])

			p "publishes quantity: #{@publishes.count}"

		else	

			@publishes = Publish.joins(products: :product_images).where("products.state_id = ?", 
				@state.id).distinct("publishes.id").order("publishes.created_at desc").page(params[:page])


		end
	end

	def works
		# for meny
		# @categories = PublishCategory.all => change to helper

		@state = State.find_by(name: "active")

		if params[:user_id] 

			# for public
			@user = User.find(params[:user_id])

			@publishes = nil

			if params[:publish_category] || params[:sell]

				p "parameter: #{params[:publish_category]}, #{params[:sell]}"

				category_id = "%"
				if params[:publish_category] != 'all'
					@category = PublishCategory.find_by(name: params[:publish_category])
					if @category.nil?
					else
						category_id = @category.id
					end
				end
				
				p "parameter: #{params[:publish_category]}:#{category_id}, #{params[:sell]}"

				@publishes = Publish.joins(products: :product_images).where('publishes.publish_category_id LIKE ? AND products.state_id =? AND publishes.user_id = ?', 
				category_id, @state.id, @user.id).distinct("publishes.id").order("publishes.created_at desc")
				p "publishes quantity: #{@publishes.count}"
				if params[:sell] == '1'
					@order_state  = State.find_by(name: "completed")
					@publishes = Publish.joins(:products => [{order_items: :order}, :product_images]).where("publishes.user_id = ? AND publishes.publish_category_id LIKE ? AND orders.state_id = ? AND products.state_id = ?", 
						@user.id, category_id, @order_state.id, @state.id).distinct("publishes.id").order("publishes.created_at desc")
				end

			else	
			@publishes =  Publish.joins(products: :product_images).where("products.state_id = ? AND publishes.user_id = ?", 
				@state.id, @user.id).distinct("publishes.id").order("publishes.created_at desc")


			end
			render 'works', object: @publishes, :layout => "works"
		end	
	end

	def new 
		render "new"
	end

	def upload
	end

	def create
		# eatch Publish belongs to an user
		@publish = current_user.publishes.create(params[:publish].permit(:name, :description, :isOriginal, :publish_category_id, :state_id, :publish_image))

		if @publish.save

			# should notice frontend
			#flash[:notice] = "Successfully uploaded"
			#redirect_to @illstration
			#products_array = Product.generate_products(@Publish)
			# do not understand

			#not here to produce products response
			#@products = Product.all
			#render :partial => "products/list", collection: @products

			# render partial: "image", object: @publish

			# render json cannot set gon variable
			# set publish_id for front js
			#gon.push({
			#	:publish_id => @publish.id
			#	})
			#gon.publish_id = @publish.id

			@templates = ProductTemplate.all
			render json: {publish_id: @publish.id, templates: @templates.to_json(only: [:id])}

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
		@user = @publish.user
	end

	def destroy
		@publish = Publish.find(params[:id])
		@completed_state = State.find_by(name: "completed")
		#@deleted_state = State.find_by_name("deleted")
		count_in_order = Product.joins(order_items: :order).joins(:publish).where("publishes.id = ? and orders.state_id != ?", 
			@publish.id, @completed_state.id).count
		count_in_cart  = Product.joins(:line_items).joins(:publish).where("publishes.id = ? ", @publish.id).count

		respond_to do |format|

			if count_in_cart == 0 && count_in_order == 0

				if @publish.destroy				
      				 format.json { render json: { notice: t('flash.notices.publish_deleted') } }
				else
					format.json { render json: { alert: t('flash.alerts.publish_deleted_alert') }, status: :internal_server_error }
				end
			else
				format.json {render json: { alert: t('flash.alerts.publish_deleted_forbid') }, status: :forbidden }
			end
		end
	end


	def reset
		@publish = Publish.find(params[:publish_id])

		# clear session
		session[:publish_id] = nil

		respond_to do |format|
			if @publish.destroy 
				format.text{render text: t('flash.notices.reset_tougao')}
			else
				format.text{render text: t('flash.alerts.reset_tougao_alert'), status: :internal_server_error}
			end
		end
	end

	def commit
		@publish = Publish.find(params[:publish_id])

		# clear session
		session[:publish_id] = nil

		@products = @publish.products

		@state = State.find_by_name("active")
		respond_to do |format|
			if @products.update_all({:state_id => @state.id})
				format.text{render text: t('flash.notices.commit_tougao')}
			else
				format.text{render text: t('flash.alerts.commit_tougao_alert'), status: :internal_server_error}
			end
		end
	end

end
