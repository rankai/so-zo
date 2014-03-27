class PublishCategory < ActiveRecord::Migration
  def change
  	create_table :publish_categories do |t|

  		t.string	:name, :null => false
  		t.text		:description

  		t.timestamps
  	end

  	add_column :publishes, :publish_category_id, :integer
  	add_index(:publishes, :publish_category_id)
  end
end
