module ProductsHelper

	def product_pages(counts)
		if counts < 3
			1
		elsif (counts % 3) != 0
			count/3 + 1
		else
			count/3
		end
	end

	def get_illustration_image(product)
		product.illustration.ill_image
	end
end
