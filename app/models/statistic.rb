class Statistic < ActiveRecord::Base
	belongs_to :user

	def self.create_or_update_statistic(object_id, object_type, action)
		@statistic = Statistic.where("statistics.object_id = ? AND statistics.object_type = ?", object_id, object_type).first
		if @statistic.nil?	
			@statistic = Statistic.new
			@statistic.object_id = object_id
			@statistic.object_type = object_type
			@statistic.action = action
			@statistic.count = 1
			@statistic.save
		else
			@statistic.update_attribute(:count, @statistic.count + 1)
		end
	end
end

=begin
	object_type:
		'P': publish
		'C': Commodity
		'U': User
		'T': Template
	
	action:
		'V': view
		'A': Add_to_Cart
		'C': Collect
		'S': Sell
		'W': Watch
=end

