class RemoveTempalteIdFieldsOnProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :template_id
  end
end
