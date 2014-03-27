class RedesignTableIllustrations < ActiveRecord::Migration
  def change

  	rename_column :products, :illustration_id, :publish_id
  	drop_table :illustrations

  	create_table :publishes do |t|
  		t.string         :name, 		 :null => false
  		t.text   		 :description,   :null => false
  		t.belongs_to     :user,          :null => false
  		t.belongs_to     :state,         :null => false
  		t.attachment     :product_image, :null => false

  		t.timestamps
  	end

  	add_index(:publishes, :user_id)
  end
end
