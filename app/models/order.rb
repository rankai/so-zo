class Order < ActiveRecord::Base
	require 'multi_json'

	belongs_to :user
	has_many   :order_items, dependent: :destroy
	belongs_to :state 

end