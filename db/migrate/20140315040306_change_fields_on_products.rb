class ChangeFieldsOnProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :tempalte_id
  	remove_column :products, :illustration_id

  	add_column 	  :products, :product_template_id, :integer
  	add_column    :products, :illustration_id,     :integer

  	add_index(:products,[:product_template_id, :illustration_id])

  end
end
