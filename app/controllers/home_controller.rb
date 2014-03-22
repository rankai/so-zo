class HomeController < ApplicationController
	#layout false
	#before_filter :authenticate_user!

	def index
		@products = Product.last(8)
	end

	def login
	end

	def register
	end

	def logout
		session[:user_id] = nil;
	end
end
