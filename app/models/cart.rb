class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	#def add_product(product_id)
	#end
end
