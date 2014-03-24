class Order < ActiveRecord::Base
	belongs_to :user
	has_many   :order_items
	belongs_to :state
end