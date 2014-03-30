class Order < ActiveRecord::Base
	require 'multi_json'

	belongs_to :user
	has_many   :order_items, dependent: :destroy
	has_many   :products, :through => :order_items
	belongs_to :state 


	def self.search(search, current_user)
	  if search
	    #current_user.orders.where('order_number LIKE ?', "%#{search}%")
		current_user.orders.joins(:products).where('products.name LIKE ? OR orders.order_number LIKE ?', "%#{search}%", "%#{search}%")
		#SELECT "orders".* FROM "orders" INNER JOIN "order_items" ON "order_items"."order_id" = "orders"."id" 
		#INNER JOIN "products" ON "products"."id" = "order_items"."product_id" WHERE "orders"."user_id" = ? 
		#AND (products.name LIKE '%Frame%')
	  else
	    scoped
	  end
	end

end