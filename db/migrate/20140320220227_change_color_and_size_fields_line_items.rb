class ChangeColorAndSizeFieldsLineItems < ActiveRecord::Migration
  def change
  	remove_column :line_items, :color
  	remove_column :line_items, :size
  	add_column    :line_items, :color_id, :integer
  	add_column    :line_items, :size_id,  :integer
  end
end
