class ChangeFieldsLineItems < ActiveRecord::Migration
  def change
  	rename_column :line_items, :count, :quantity
  end
end
