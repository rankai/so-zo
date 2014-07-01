class SearchController < ApplicationController
	def search
		if params[:resource_type_code] || params[:resource_type]
			keywords = ""
			if params[:search_field]
				keywords = params[:search_field]
			end
			if params[:resource_type_code] == 'w' # w means works, c means products
				p 'publishes'
				redirect_to publishes_path(publish_category: params[:resource_type], keywords: keywords)
			else
				p 'products'
				redirect_to products_path(product_category: params[:resource_type], keywords: keywords)
			end
		else
			p 'empty'
			redirect_to root_path
			
		end
	end
end
