class OrdersController < ApplicationController
	before_filter :authenticate_user!

	def show
	end

	def new
	end

	def create
		@order = Order.new
		render partial: "confirmed", object: @order
	end

	def destroy
	end

end
