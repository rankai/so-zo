class Size < ActiveRecord::Base
	has_and_belongs_to_many :product_templates
end
