class AddBriefFieldToProductTemplate < ActiveRecord::Migration
  def change
  	add_column :product_templates, :brief, :string, null: false, default: ''
  end
end
