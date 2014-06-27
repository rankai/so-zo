class HomeController < ApplicationController
	#layout false
	#before_filter :authenticate_user!

	def index
		@state = State.find_by(name: "active")
		#@products = Product.joins(:product_images).where("products.state_id = ?", 
		#	@state.id).distinct("products.id").order("created_at desc").limit(8)
	end
	
	def logout
		session[:user_id] = nil;
	end

	def intro
	end

	def treaty
	end
end
