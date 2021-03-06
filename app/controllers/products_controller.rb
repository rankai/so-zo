require "pusher"
require "redis-queue"
require "thread"
class ProductsController < ApplicationController
		include ActionController::Live

	before_filter :authenticate_user!, :except => [:show, :index, :top, :products]

	# check results
	def results
		response.headers['Content-Type'] = 'text/event-stream'
		sse = Pusher::SSE.new(response.stream)
		# Looper.new.async.perform(queue, sse)
		job_id = params[:job_id]
		# redis = Redis.new
		#Create a queue that will listen for a new element for 10 seconds
		queue = Redis::Queue.new("__#{job_id}", "bp__#{job_id}", :redis => $redis)

		#When all elements are dequeud, process method will wait for 10 secods before exit
		# queue.process do |message|
		#   puts "'#{message}'" 
		# end


		begin
			queue.process(true) do |message|
				
				# if message.include? '/'
				# 	p "#{message}"
			 # 		sse.write({data: "#{message}"}, event: "update")
			 # 	elsif message == 'finished'
			 # 		# sse.write({msg: "sss"}, event: 'results')
			 # 		sse.write({data: ""}, event: "finished")
			 # 	else
			 # 		# useless now
			 # 	end

				if message == 'finished'
					p "finished"
					sse.write({data: "#{message}"}, event: "finished")
				elsif not message.blank?
					p "update"
					p "#{message}"
					sse.write({data: "#{message}"}, event: "update")
				else
				end

				queue.commit
			end
		rescue IOError
			#
		ensure
			sse.close
		end

		# Looper.new.async.perform(queue, sse)

	end

	def preview
		if params[:publish_id]
			@publish = Publish.find(params[:publish_id])
			@products = Product.where("products.publish_id = ?", @publish.id)

			if @products.nil? || @products.count == 0
				redirect_to new_user_publish_path(@user), alert: t('flash.alerts.commit_tougao_alert')
			else
				render partial: "list", object: @products
			end
		end
	end
	
	def job
        # validate legal?
        if params[:publish_id]

        	uuid = UUID.new.generate(:compact)
			@publish = Publish.find(params[:publish_id])
			# @products = Product.generate_products(@publish)

			# if @products.nil? || @products.count == 0
			# 	redirect_to new_user_publish_path(@user), alert: t('flash.alerts.commit_tougao_alert')
			# else
			# 	GenerateProductsJob.new.async.perform(queue, "haha")
			# 	# render partial: "list", object: @products
			# end
			t = Thread.new do
		   	# We should use a second connection here since the first one is busy 
		   	# on a blocking call

				_redis = Redis.new
				# _queue = Redis::Queue.new('__test', 'bp__test', :redis => _redis)
				_queue = Redis::Queue.new("__#{uuid}", "bp__#{uuid}", :redis => _redis)
				p "#{uuid}"
				@product_templates = ProductTemplate.all
				templates_length = @product_templates.count
				@product_templates.each_with_index do |template, index|
					@product = Product.generate_product(@publish, template)
					if @product.present?
						_queue << "#{templates_length}/#{index+1}"
					end
				end

				_queue << "finished"

			end
   			# _queue = Redis::Queue.new('__test', 'bp__test', :redis => $redis)

			# GenerateProductsJob.new.async.perform(_queue, "haha")
			render status: 202, text: "job_id:#{uuid}"
			# t.join
		else
			# invalid request
		end
	end

	def index
		# for meny to output menu
		@categories = TemplateCategory.all

		#need validate nil
		@state = State.find_by(name: "active")
			
		@products = nil

		if params[:product_category]

			category_id = "%"
			if params[:product_category] != 'all'
				@category = TemplateCategory.find_by(name: params[:product_category])
				if @category.nil?
				else
					category_id = @category.id
				end
			end			

			keywords = "%"
			if params[:keywords] && params[:keywords] != ""
				keywords = "%#{params[:keywords]}%"
			end

			@products = Product.joins(:product_template).joins(:product_images)
			.where('product_templates.template_category_id LIKE ? AND products.name LIKE ? AND products.state_id = ?',
			 category_id, keywords, @state.id).distinct("products.id").order("products.created_at desc").page(params[:page])

		else
			@products = Product.joins(:product_images).where(:state => @state).distinct("products.id")
				.order("products.created_at desc").page(params[:page])
		end
	end

	def products
		@categories = TemplateCategory.all
		#need validate nil
		@state = State.find_by(name: "active")

		if params[:user_id]

			@user = User.find(params[:user_id])
			
			@publishes = nil
			if params[:product_category] || params[:sell]

				category_id = "%"
				if params[:product_category] != 'all'
					@category = TemplateCategory.find_by(name: params[:product_category])
					if @category.nil?
					else
						category_id = @category.id
					end
				end			

				@products = @user.products.joins(:product_template).joins(:product_images).where('product_templates.template_category_id LIKE ? AND products.state_id = ?',
				 category_id, @state.id).distinct("products.id").order("products.created_at desc")

				if params[:sell] == '1'
					@complete_state = State.find_by(name: "completed")
					#need validate nil
					@products = Product.joins(:order_items).joins(:publish).joins(:product_template).joins(:product_images).where("publishes.user_id = ? AND product_templates.template_category_id LIKE ? AND products.state_id = ?",
					@user.id, category_id, @complete_state.id).distinct("products.id").order("products.created_at desc")
				end

			else

			@products = @user.products.joins(:product_images).where("products.state_id = ?", @state.id).distinct("products.id").order("products.created_at desc")


			end

			render "products", object: @products, layout: "works"

		end
	end

	def show
		@product = Product.find(params[:id])
		@user = @product.publish.user
		gon.product_id = @product.id

		# TODO: Add view statistics
		Statistic.create_or_update_statistic(@product.id, 'C', 'V')

		respond_to do |format|
			format.html {render "show"}
		end

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
		@publish = Publish.find(params[:publish_id])
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

			state_id = State.find_by(name: "completed").id
			in_order_count = count_in_order = Product.joins(order_items: :order).where("products.id = ? and orders.state_id != ?", 
				@product.id, state_id).count

			in_cart_count = @product.line_items.count
			publish_product_count = @product.publish.products.count - 1 # exclusion this one

			p "product in cart: #{in_cart_count}, in order: #{in_order_count}, the pulish has another #{publish_product_count} products"

			#if @publish.update_attribute(:state, @state)
			if publish_product_count > 0 

				if @product.state.name == "inactive"

					if @product.destroy
						format.text{render text: t('flash.notices.product_deleted')}
					else
						format.text{render text: t('flash.alerts.product_deleted_alert'), status: :internal_server_error}
					end
				
				else	

					if in_order_count == 0 && in_cart_count == 0
						if @product.destroy
								 format.json { render json: { notice: t('flash.notices.publish_deleted') } }
						else
							format.json { render json: { alert: t('flash.alerts.product_deleted_alert') }, status: :internal_server_error }
						end
					else
						format.json {render json: { alert: t('flash.alerts.product_deleted_forbid') }, status: :forbidden }
					end

				end

			else
				format.json { render json: { alert: t('flash.alerts.last_product_deleted_forbid') }, status: :forbidden }
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
    
    # for top 2014-04-06 23:10 optimize category query
	def top
       
		# make orders
		count = 10
		state_id = State.find_by(name: "completed").id
		@products = Array.new
		@top_products = Product.joins(order_items: :order).where("orders.state_id = ?", state_id)
		#@top_products = Product.joins(order_items: :order).where("orders.state_id = ?", 
		#		state_id).count(:group => "products.id", :order => 'count_all asc', :limit => count)

		if params[:product_category]

			@category = TemplateCategory.find_by(name: params[:product_category])
			if @category.nil?
			else
				#@top_products = Product.joins(:product_template).joins(order_items: :order).where("orders.state_id = ? AND product_templates.template_category_id = ?", 
				#	state_id, @category.id).count(:group => "products.id", :order => 'count_all asc', :limit => count)
                @top_products = @top_products.joins(:product_template).where("product_templates.template_category_id = ?", @category.id)
			end
		end

		@top_products = @top_products.count(:group => "products.id", :order => 'count_all asc', :limit => count)

		render "top", object: @top_products

	end
 
 	# any others 

 	
		#  after do
		#   ActiveRecord::Base.connection.close
		# end

end
