class ChangePriceFieldsType < ActiveRecord::Migration
  def change
  	change_column :products, :price, :decimal
  	change_column :product_templates, :price, :decimal
  end
end
