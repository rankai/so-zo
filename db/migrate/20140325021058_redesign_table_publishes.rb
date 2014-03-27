class RedesignTablePublishes < ActiveRecord::Migration
  def change
  	remove_attachment :publishes, :product_image
  	add_attachment	  :publishes, :publish_image

  	drop_table        :illustrations_tags

  	create_table :publishes_tags do |t|
  		t.belongs_to :publish
  		t.belongs_to :tag

  		t.timestamps
  	end
  end
end
