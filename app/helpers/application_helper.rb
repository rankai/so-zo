module ApplicationHelper
	def get_about_us
		@base = Base.where(:title => "about_us").first
		@base.detail
	end

	def get_order_confirmed_message
		@base = Base.where(:title => "order_confirmed").first
		@base.detail
	end
end
