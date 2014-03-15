class AddProductPriceFieldOnProducts < ActiveRecord::Migration
  def change
  	add_column :products, :price, :integer
  	# if $3.49, stored as 349; if $349, stored as 34900
  end
end
