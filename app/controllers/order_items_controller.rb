class OrderItemsController < ApplicationController
	before_filter :authenticate_user!
	belongs_to :product
end
