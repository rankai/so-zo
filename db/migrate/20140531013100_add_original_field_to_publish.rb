class AddOriginalFieldToPublish < ActiveRecord::Migration
  def change
  	add_column :publishes, :isOriginal, :integer, null: false, default: 0
  end
end
