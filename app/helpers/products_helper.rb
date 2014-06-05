module ProductsHelper

	def product_pages(relative_product_count)
		counts = relative_product_count
		if counts <= 3
			1
		elsif (counts % 3) != 0
			counts/3 + 1
		else
			counts/3
		end
	end

	def relative_products(product)
		product.publish.products.where("products.id != ?", product.id)
	end

end
