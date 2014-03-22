class OrderItemsController < ApplicationController
	before_filter :authenticate_user!
end
